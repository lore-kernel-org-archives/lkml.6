Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtOiUqgTSHCZ73PD0Xk7bHX23kJOpTofhuuZtzAT24yAFwRBX8AdxkCNvfia1il6ewgwR1p
ARC-Seal: i=1; a=rsa-sha256; t=1519981095; cv=none;
        d=google.com; s=arc-20160816;
        b=Urmj+6qKMZyt/lTi+vPRDbdfuQYogZ2kwQ3qh47hACGeIx2TcLDItNfS1WgjSFxJx5
         DuEhabfE+oczAL+ic+Y72Amfx4RVKIxrLQtFum9+ax1ZnfreEWwu2gE0+dXijoThuodS
         ZKMCcEhriznN2GwFDRLENKcZb1a06vkJySvK0mmVea06q4ON8y6ValkwXfy1JqjnDwQ+
         D9KcgWS4Wp/axc8HClRPVJSEUASk2XhMIZaJ2Ymim5AGZfUPJ1xXuVWAe+sZkPhtjGZ+
         tzJX/WO1IS/11jafymK1QHBPvy1u/XU9z6MjGYD3793n89P8WG9/Sp8pIlJd1gbmU4HQ
         TACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0OlhBHARvhyVnUsixBqAbTKUib7fQWIirojInsgZfoc=;
        b=xzi8jD0OUDCvxgIhxCCEDMS4KLn+5NETvIxXJVJyd7gR9kHOQwWfTNW8P6/Dx9Vt30
         5dWOaJsnmdJrO8dnxRxpzUVrfoFxlNHipVrNojy0AVs/CdFcufSLNuB1BTB3laJ+g+Oe
         5K4itFu4NvjvrG5rbIvPybF8gPyVEH19KNbbDRH922TMerpEJL81NVfUWm2SYJxo9RmC
         V4j7GXhi7WB+PdI5sOgLbWUrvj7BEYkvzXR2YiJc0NpuqoUSy5HLoGbY3Ieo5JOldaih
         0eHNCOe7Pekx1LnQ7xLTVIj29TSTkO9gsPwdqoGcSyss4LblSYoViZqBk1zC0PgCAXOu
         hTqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Luu An Phu <phu.luuan@nxp.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 46/56] can: flex_can: Correct the checking for frame length in flexcan_start_xmit()
Date: Fri,  2 Mar 2018 09:51:32 +0100
Message-Id: <20180302084451.887462391@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815491970045896?=
X-GMAIL-MSGID: =?utf-8?q?1593815697254379095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luu An Phu <phu.luuan@nxp.com>


[ Upstream commit 13454c14550065fcc1705d6bd4ee6d40e057099f ]

The flexcan_start_xmit() function compares the frame length with data
register length to write frame content into data[0] and data[1]
register. Data register length is 4 bytes and frame maximum length is 8
bytes.

Fix the check that compares frame length with 3. Because the register
length is 4.

Signed-off-by: Luu An Phu <phu.luuan@nxp.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/flexcan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -493,7 +493,7 @@ static int flexcan_start_xmit(struct sk_
 		data = be32_to_cpup((__be32 *)&cf->data[0]);
 		flexcan_write(data, &regs->mb[FLEXCAN_TX_BUF_ID].data[0]);
 	}
-	if (cf->can_dlc > 3) {
+	if (cf->can_dlc > 4) {
 		data = be32_to_cpup((__be32 *)&cf->data[4]);
 		flexcan_write(data, &regs->mb[FLEXCAN_TX_BUF_ID].data[1]);
 	}
