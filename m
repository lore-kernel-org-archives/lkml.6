Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoeeknmhJH6soa4dFXZwDNYUL9zZIhNYhc4D7/ENQzHtsbfPCTYo97e7T59kK8OHnYbKcK7
ARC-Seal: i=1; a=rsa-sha256; t=1526937546; cv=none;
        d=google.com; s=arc-20160816;
        b=sgp8031QCC7oVhDZUiR8IW484USUVYCzbk3FLOFYW4zyWhbWdjxLCWOM6Q50mRyd2a
         T6OKk2TmPqOgb1Ho41TclP8OZYl3Jtw4ZMYDaTrw1isap0rbJQNCAc1PQSsybHYpzuZ3
         SPA4EFx6bBeu+ZU9uNClSpXnXrvVO3FFjtehagd1LT6Lo6DWdP9aKxl4mkWOCpkfOaF3
         rmMqWFIAUMIbPZ8ztKPFzJ3wsDolZrTkA5GxdAtPlAPRsm7rX4wFaez4wpDXJqYEOA7Y
         XUq0O0H9z8+49Eg6jAJjpnS5c1UpmUcxBYWz17vDtwsjmYomPUQtF6VStvy1wpyCbA17
         8u8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=rqAgsK1HhTA6Ols/DgqSgFa2QENWNbu13RVBTijFzIQ=;
        b=lBtrQ+CyO9fKVniP/ooKFUys+/ZFQAgvavffdzdF2vKa8WVaAmzBMOcaRQuJqwVmAX
         wydnSQqUvuEJvR46On0E/gvPDz4xSc+E9R06lvgadqYejvPMMcN6SC77lz/nxZz24ZHO
         0w9ob7QmI7Z2dKcVUYp475nBvLKy8apX2SOAUcZC9oTd6y1h0mdWjawNLhHC3yi7fbD3
         +KO3seGRwuV8/HI6L7zLsILskdCR6St+ou24Hww8KqiqE7DOyPg986WFKEzWNqpO95GQ
         x/ctoh13XXdZQVuEi/V31y0gDv4YTf06oi8r2dUUNFj0w39Y2L2sq+OCNRitSWAjvP3P
         llDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vqN3gXws;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vqN3gXws;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.14 05/95] usbip: usbip_host: fix bad unlock balance during stub_probe()
Date: Mon, 21 May 2018 23:10:55 +0200
Message-Id: <20180521210448.301526751@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109766152397439?=
X-GMAIL-MSGID: =?utf-8?q?1601110064880355732?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
