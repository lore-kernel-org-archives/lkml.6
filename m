Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo+Y+THQ47mDMf9dfIEiI6rWpLRziGDgaAHOYP5OyFXgbabyqxFH+bkA5fqCIA3U75DlaE6
ARC-Seal: i=1; a=rsa-sha256; t=1525767196; cv=none;
        d=google.com; s=arc-20160816;
        b=uK5kt/f4P6TcZfPHeV1vq4nQyocWlNe9/kJiRhdGbZmMRqTlLGjg1GtCDTIeskMLTK
         JJKqKfP0DIIjh6IpzK5bBIZXINTF9fA6PWq0y74z/aIbqZd/3WfQ72lpjzEL6aZK7n0P
         3Xq6BnT/fy5mifKQ/fbfot4EDnD+LqbQaLJ42oLHroOlB1ZImjylsNNIxiTYJnAOQG21
         tAw55r64jcQAqgxZ3DYybAWUejr8u/qyPxhXsa7yn7RhL5xmAiByb9DbsdntREGNBAiE
         YrIENM4fS1IpHlT3qiAe0JAOc9bbaOcWWGuCey4Mqx+MnfgsUzJICHArNO6P7tTSBRJp
         u2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0L/f2mJpawJasx7s0obG33mLHG/vWP2ZsRZ7OyDsCsM=;
        b=eUrOqwtpPa+NscF7P4xSZZr+maNyrpLVhSbo6Ky7RniwFPuhLIRhihfBpUuViKKpq4
         /5wCW0MHlHqVb75cOZ58IIO55AweM4x3zJmISXItclnRrQkfDAD9EPuHGfLT+MwUpD+w
         a5+jrItxWTMdEPku0IyfdJCTrroLpCXCgfxH/YTYnQlHFsXg8TIMLirz6EdjjAM0I52m
         zA/rtAVtnzlQ3dYVMmyKVlRVukNnNFMRJJsPCE739iKRgUiQjQgJAdKQ6vfIgkuAVpN2
         L6v0ZBW3kf8ydqwYXBQpfSHmmE877GHjZQMybzEhCE+qn08aaetVZLmo9IRm2b61oHPv
         nyzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JsKgf+Hw;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JsKgf+Hw;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.16 15/52] rtlwifi: cleanup 8723be ant_sel definition
Date: Tue,  8 May 2018 10:10:13 +0200
Message-Id: <20180508073930.083368644@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882863603452089?=
X-GMAIL-MSGID: =?utf-8?q?1599882863603452089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

commit af8a41cccf8f469165c6debc8fe07c5fd2ca501a upstream.

Some HP laptops have only a single wifi antenna. This would not be a
problem except that they were shipped with an incorrectly encoded
EFUSE. It should have been possible to open the computer and transfer
the antenna connection to the other terminal except that such action
might void the warranty, and moving the antenna broke the Windows
driver. The fix was to add a module option that would override the
EFUSE encoding. That was done with commit c18d8f509571 ("rtlwifi:
rtl8723be: Add antenna select module parameter"). There was still a
problem with Bluetooth coexistence, which was addressed with commit
baa170229095 ("rtlwifi: btcoexist: Implement antenna selection").
There were still problems, thus there were commit 0ff78adeef11
("rtlwifi: rtl8723be: fix ant_sel code") and commit 6d6226928369
("rtlwifi: btcoexist: Fix antenna selection code"). Despite all these
attempts at fixing the problem, the code is not yet right. A proper
fix is important as there are now instances of laptops having
RTL8723DE chips with the same problem.

The module parameter ant_sel is used to control antenna number and path.
At present enum ANT_{X2,X1} is used to define the antenna number, but
this choice is not intuitive, thus change to a new enum ANT_{MAIN,AUX}
to make it more readable. This change showed examples where incorrect
values were used. It was also possible to remove a workaround in
halbtcoutsrc.c.

The experimental results with single antenna connected to specific path
are now as follows:
  ant_sel  ANT_MAIN(#1)  ANT_AUX(#2)
     0        -8            -62
     1        -62           -10
     2        -6            -60

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Fixes: c18d8f509571 ("rtlwifi: rtl8723be: Add antenna select module parameter")
Fixes: baa170229095 ("rtlwifi: btcoexist: Implement antenna selection")
Fixes: 0ff78adeef11 ("rtlwifi: rtl8723be: fix ant_sel code")
Fixes: 6d6226928369 ("rtlwifi: btcoexist: Fix antenna selection code")
Cc: Stable <stable@vger.kernel.org> # 4.7+
Reviewed-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c |   15 ----------
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c           |   11 ++++---
 drivers/net/wireless/realtek/rtlwifi/wifi.h                   |    5 +++
 3 files changed, 12 insertions(+), 19 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -158,16 +158,6 @@ static u8 halbtc_get_wifi_central_chnl(s
 
 static u8 rtl_get_hwpg_single_ant_path(struct rtl_priv *rtlpriv)
 {
-	struct rtl_mod_params *mod_params = rtlpriv->cfg->mod_params;
-
-	/* override ant_num / ant_path */
-	if (mod_params->ant_sel) {
-		rtlpriv->btcoexist.btc_info.ant_num =
-			(mod_params->ant_sel == 1 ? ANT_X2 : ANT_X1);
-
-		rtlpriv->btcoexist.btc_info.single_ant_path =
-			(mod_params->ant_sel == 1 ? 0 : 1);
-	}
 	return rtlpriv->btcoexist.btc_info.single_ant_path;
 }
 
@@ -178,7 +168,6 @@ static u8 rtl_get_hwpg_bt_type(struct rt
 
 static u8 rtl_get_hwpg_ant_num(struct rtl_priv *rtlpriv)
 {
-	struct rtl_mod_params *mod_params = rtlpriv->cfg->mod_params;
 	u8 num;
 
 	if (rtlpriv->btcoexist.btc_info.ant_num == ANT_X2)
@@ -186,10 +175,6 @@ static u8 rtl_get_hwpg_ant_num(struct rt
 	else
 		num = 1;
 
-	/* override ant_num / ant_path */
-	if (mod_params->ant_sel)
-		num = (mod_params->ant_sel == 1 ? ANT_X2 : ANT_X1) + 1;
-
 	return num;
 }
 
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -848,6 +848,9 @@ static bool _rtl8723be_init_mac(struct i
 		return false;
 	}
 
+	if (rtlpriv->cfg->ops->get_btc_status())
+		rtlpriv->btcoexist.btc_ops->btc_power_on_setting(rtlpriv);
+
 	bytetmp = rtl_read_byte(rtlpriv, REG_MULTI_FUNC_CTRL);
 	rtl_write_byte(rtlpriv, REG_MULTI_FUNC_CTRL, bytetmp | BIT(3));
 
@@ -2696,21 +2699,21 @@ void rtl8723be_read_bt_coexist_info_from
 		rtlpriv->btcoexist.btc_info.bt_type = BT_RTL8723B;
 		rtlpriv->btcoexist.btc_info.ant_num = (value & 0x1);
 		rtlpriv->btcoexist.btc_info.single_ant_path =
-			 (value & 0x40);	/*0xc3[6]*/
+			 (value & 0x40 ? ANT_AUX : ANT_MAIN);	/*0xc3[6]*/
 	} else {
 		rtlpriv->btcoexist.btc_info.btcoexist = 0;
 		rtlpriv->btcoexist.btc_info.bt_type = BT_RTL8723B;
 		rtlpriv->btcoexist.btc_info.ant_num = ANT_X2;
-		rtlpriv->btcoexist.btc_info.single_ant_path = 0;
+		rtlpriv->btcoexist.btc_info.single_ant_path = ANT_MAIN;
 	}
 
 	/* override ant_num / ant_path */
 	if (mod_params->ant_sel) {
 		rtlpriv->btcoexist.btc_info.ant_num =
-			(mod_params->ant_sel == 1 ? ANT_X2 : ANT_X1);
+			(mod_params->ant_sel == 1 ? ANT_X1 : ANT_X2);
 
 		rtlpriv->btcoexist.btc_info.single_ant_path =
-			(mod_params->ant_sel == 1 ? 0 : 1);
+			(mod_params->ant_sel == 1 ? ANT_AUX : ANT_MAIN);
 	}
 }
 
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2759,6 +2759,11 @@ enum bt_ant_num {
 	ANT_X1 = 1,
 };
 
+enum bt_ant_path {
+	ANT_MAIN = 0,
+	ANT_AUX = 1,
+};
+
 enum bt_co_type {
 	BT_2WIRE = 0,
 	BT_ISSC_3WIRE = 1,
