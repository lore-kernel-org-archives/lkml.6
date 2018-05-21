Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp8swPuMpEt5XZEcO25TW2RfqRsT1YD7cV7jV/gppTDhtGQ+gUnOpJhsM/+FYZWwyB0Pbs0
ARC-Seal: i=1; a=rsa-sha256; t=1526937261; cv=none;
        d=google.com; s=arc-20160816;
        b=rDUdcH9aMqxavrTL704L5hausHdrmjSHVKjBJhw+L5mlAZt+1X0DTM7d0rgqZiClri
         /wC9bs4Zq7bdC8Upj/oPQbq1UEdxkCiic2KoOwYP0hh4N5clrGgDAKZCOhb3PvC5yD5d
         CNy6/b8+UTB4QCLqrHm7uVhwwGHX2fczXVZd73vkuvEe14iBZZchHb6wWOrXkv2Wuqy9
         otTACuAxvIBhRA5u6DlWOLigLvo6s6H5JIFbNxgUCTwWHqlGwi2WGxBcNem6mqPelYo9
         1MpsdUcs26lDY97Umo5qTnBI/Em1udQ7cfen/1DwzgLGxRjgYoK8DIYgT9XUAm/dfWr+
         bevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NAkjAP4Q/ksLrjHMFywwlcx2mLrvSADmMNq87f+yBEo=;
        b=MnQUY6qSv0xpKlK9l1q+dCPozafB2XJ/xUIpJpUc15iSqGj4rTcOL7cGpeYFfX27wq
         a+b34N6Z/WDHpYa/U51OunrQ4GcIzSb1AnRTczXUY1Svk58DNX1sAQj5O3AC5lABugvw
         lPoJf9G2KLwRQIPXMadijf2T1mYKUITPRWWGOdwtXIpINhXKu+36kNiOdE2wm1pW3/Tm
         36l1FDhLHOXMRDPfp1JdeetT2khtwaD/OH+JfkB3HH0jkz1q25CaTi6Z7DJhe4ctCvPz
         U3CY9+Km6ph2w8D2Wu3r4GsuKro5n4PRcUDLS6M2AQOrj4cHtfmuU8ac5zJOOBiAst1Z
         SIZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EOSQUAgG;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EOSQUAgG;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.9 05/87] usbip: usbip_host: fix bad unlock balance during stub_probe()
Date: Mon, 21 May 2018 23:10:41 +0200
Message-Id: <20180521210420.722205109@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109766152397439?=
X-GMAIL-MSGID: =?utf-8?q?1601109766152397439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit c171654caa875919be3c533d3518da8be5be966e upstream.

stub_probe() calls put_busid_priv() in an error path when device isn't
found in the busid_table. Fix it by making put_busid_priv() safe to be
called with null struct bus_id_priv pointer.

This problem happens when "usbip bind" is run without loading usbip_host
driver and then running modprobe. The first failed bind attempt unbinds
the device from the original driver and when usbip_host is modprobed,
stub_probe() runs and doesn't find the device in its busid table and calls
put_busid_priv(0 with null bus_id_priv pointer.

usbip-host 3-10.2: 3-10.2 is not in match_busid table...  skip!

[  367.359679] =====================================
[  367.359681] WARNING: bad unlock balance detected!
[  367.359683] 4.17.0-rc4+ #5 Not tainted
[  367.359685] -------------------------------------
[  367.359688] modprobe/2768 is trying to release lock (
[  367.359689]
==================================================================
[  367.359696] BUG: KASAN: null-ptr-deref in print_unlock_imbalance_bug+0x99/0x110
[  367.359699] Read of size 8 at addr 0000000000000058 by task modprobe/2768

[  367.359705] CPU: 4 PID: 2768 Comm: modprobe Not tainted 4.17.0-rc4+ #5

Fixes: 22076557b07c ("usbip: usbip_host: fix NULL-ptr deref and use-after-free errors") in usb-linus
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -96,7 +96,8 @@ struct bus_id_priv *get_busid_priv(const
 
 void put_busid_priv(struct bus_id_priv *bid)
 {
-	spin_unlock(&bid->busid_lock);
+	if (bid)
+		spin_unlock(&bid->busid_lock);
 }
 
 static int add_match_busid(char *busid)
