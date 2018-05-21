Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrct7pF3BEDZpEymYcQHEd5uFmfLbrRVduFpzbdy7clbIox59XGU96mYeJxllMG8yh6iA4p
ARC-Seal: i=1; a=rsa-sha256; t=1526937804; cv=none;
        d=google.com; s=arc-20160816;
        b=D79F2rJyZog4SI+jNBYQqal9utRIwVv3aBOZeuYtDA9GR5Kyp7n4MaAbxO1+qTra/M
         wUrpDtyHUStFOCWVdaFa+rZ5zLN9KRAWiVWzqTlQ9sUv7dP7lCO/LU/WBa2mZPBHmIdm
         paTFmIHrDN5/3QXzSkHEHsCIk43OLIQXs4gohoYCIyBR+aXUrYEx9iP8RvuGG/Rcb5Oi
         lySpiQIu9gQ7iP/UndXNjxoOv3KBDocDNM2YibRJy9tLXCXQJkQoo+DJUp5fkX5JwiiA
         5wA9rv7RtdaWQno8nqMokTZcvKG9Qwj7mUGvo//7esyL0pBv7VHhCFfM/hLT57kbcj9C
         uEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=RzluvsJGlIe8zYEEoNuNfr6V0Ey2eLNN7T2skHPtf6A=;
        b=HZXQNCgoh5yHuuqEuQkeuzHODU0/JKFa5O9nuVW9iCDCXpJgZ6aXXJCoSoGTPmdQgl
         JZcjofXz9HrdX6+9bZ36nEQ5LeWZILsAgWfuQ1y+llxK4XF4wf9qcqwhb2OWWYBiPG5O
         Zzlp3bw7UYIrWu5ox584RjDJ1OTaoaE21+M/YujmpprArIOLs5flsR9jW4xAVtvh35+B
         aWssOd1hStujAguuvzpEzqYk3S8snys/nSHIAX3+nq1ejcAOOTlk0kKoYzpT/pBumkJU
         JvpImGuuJ7zbuZOxpAQLoo02nB2zOloXJIqEKuticNPSvjQ8uKxgxiqkYLcQlkPNpqZa
         FhdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OMXt06P/;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OMXt06P/;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.16 006/110] usbip: usbip_host: fix bad unlock balance during stub_probe()
Date: Mon, 21 May 2018 23:11:03 +0200
Message-Id: <20180521210504.433346601@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109766152397439?=
X-GMAIL-MSGID: =?utf-8?q?1601110335921755304?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -82,7 +82,8 @@ struct bus_id_priv *get_busid_priv(const
 
 void put_busid_priv(struct bus_id_priv *bid)
 {
-	spin_unlock(&bid->busid_lock);
+	if (bid)
+		spin_unlock(&bid->busid_lock);
 }
 
 static int add_match_busid(char *busid)
