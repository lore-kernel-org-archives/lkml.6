Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoSlRk/+j+y0Xv+D4d4uTwiTkvc3uOGKYY+WYmXQdKWwlcKayl+wu25woF4RWFXt+RxqUOX
ARC-Seal: i=1; a=rsa-sha256; t=1525116524; cv=none;
        d=google.com; s=arc-20160816;
        b=WJWAD8DQcWzOSYVZMCHVHrPJWoPFFzH2DskFdGFzct9Ak0hulwnPHnUXKE+N5F0t7B
         KNCRI9X/i+aNwUqAw23vty6DXXimf9vLqxkc7EdqniYx2K//eXrAAJoD/021xrzXd5GC
         q+UGFKd4vl7G1vwYm6/3alH1oepAnXb4/EKO6IqMRi9H5KlVGPPTZS3jsYQcDJ2TFc4c
         /76nECsd+jIGDu2LMa7RRMljb9UE1WrAoL3ficQw5+l/4St5ZC+IYObyca3cWjd1yvuX
         Y4Os3opHh1zkbJLW6S9wL8dS0ARfrotZ/QtAEksmGsrO95FZ+b44YFCKxffNKO611huj
         +aAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=JLVorw3+OY1MOOYDwKvE7wctnvK8uTTuHBmFeVhzF0U=;
        b=ddQOxShHfkxxIwI5fo+QRua/hPDOPRZEzYvxZZcwwP76mNTABcU+/xsJQZc4CJqomj
         QB6AQOwlnkozBKf+ErRAlJwsSttl5O7I633ITJsetkivQszwGkDQpuX+WA0Tc6M591Ml
         8XoEgNd6pEgcPQDB87O6cOF1HIH4kcZskwMQmFX6oAN7kbIz5O843Haoaz1vuzpK/VP/
         zZB33jpDhgn+BvpV3l3do+X/pha23kO0l21LS4Os+38h/0kmngpQsWr2wPVOXUrckYBz
         szM6rQYwoXOUguLvvHJFa7NTvTU0jlcOu2pNTXBwpHvoBvuehZ7HdcuX8DtpLGiZAdI2
         ytdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D57E22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.16 075/113] ARM: amba: Dont read past the end of sysfs "driver_override" buffer
Date: Mon, 30 Apr 2018 12:24:46 -0700
Message-Id: <20180430184018.368730183@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200467272175726?=
X-GMAIL-MSGID: =?utf-8?q?1599200585300766818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit d2ffed5185df9d8d9ccd150e4340e3b6f96a8381 upstream.

When printing the driver_override parameter when it is 4095 and 4094
bytes long, the printing code would access invalid memory because we
need count + 1 bytes for printing.

Cfr. commits 4efe874aace57dba ("PCI: Don't read past the end of sysfs
"driver_override" buffer") and bf563b01c2895a4b ("driver core: platform:
Don't read past the end of "driver_override" buffer").

Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/amba/bus.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -84,7 +84,8 @@ static ssize_t driver_override_store(str
 	struct amba_device *dev = to_amba_device(_dev);
 	char *driver_override, *old, *cp;
 
-	if (count > PATH_MAX)
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
 	driver_override = kstrndup(buf, count, GFP_KERNEL);
