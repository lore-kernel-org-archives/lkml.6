Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqpywxSw/YYktZkmVw5kr0EqvLK1krlecxRZBG9gucNK9e+wYwHTG4Q5Q7x6JfAaBjA/ZRM
ARC-Seal: i=1; a=rsa-sha256; t=1527156149; cv=none;
        d=google.com; s=arc-20160816;
        b=id4EOXopXENGf7kMcHnBgx4wCXfZ1R3xRDC2Bb2qq8MRQslg4GOtQDHx+m05hYdwt2
         ndufJ5Hg2R7X8sEyFhcZ8cQN1ZD3dYCYWSGRoxedJHi9csId24QgcFV53C5JT+3wNFex
         7fdtXUW9HeIfAs5eMXxOR4MljbkuJlo6QvhVDiCMn0DNjE5mwvJkW34XxsIMgz8EF9Oa
         fjMXGfvsPNXLcq/Qfja26ohLXXDJIMocipFvEWPzYvoF1oY7jj4pOHpFOSXONS3UuMe/
         SOvEiRlwsB5vj0jT++cKlWewNIuqM80FiuU+U/+0+waC1JnpLq6m9GaOYpKdFXxCbN06
         uULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QE9vsZ9r5ojRLLGlgkfS0JRIGyKyigyWKzvcwqSPNMY=;
        b=VFd6RS4nTPRizfWvzckXG0P+E0VWkbIMF7lE5FjLCww8XipJLCYx/Z5ixt0qufTIJG
         IteM6o5dG+0JI1ZvhG3pslBjMIL4st3Ck0ysBgmLvIUXlgTTR96gl6a/UB51VNuTyo4i
         REjGa96DiII9ilqWrpIXrcmMEl66uV8FvaVUrlDQ4gm4NSLjpduSoPjQclAMzcQGprWs
         ZscFLRg+xzSVcZYd6sUCC8r/SW9sRNBnnDSYRxEpyOVEp5RL6NrkvpWgzfg9kJtrOjw7
         NPg4ckQacWPdB6T8tuwbLRa0B4lShHn9sKZ07HWzrL8iH/hNCGh8ULunq3oESdZYO2BB
         jGpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=b6XoJEIB;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=b6XoJEIB;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brad Love <brad@nextdimension.cc>,
	Michael Ira Krufky <mkrufky@linuxtv.org>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 081/161] media: em28xx: USB bulk packet size fix
Date: Thu, 24 May 2018 11:38:26 +0200
Message-Id: <20180524093028.261972329@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338423784474514?=
X-GMAIL-MSGID: =?utf-8?q?1601339287010109742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit c7c7e8d7803406daa21e96d00c357de8b77b6764 ]

Hauppauge em28xx bulk devices exhibit continuity errors and corrupted
packets, when run in VMWare virtual machines. Unknown if other
manufacturers bulk models exhibit the same issue. KVM/Qemu is unaffected.

According to documentation the maximum packet multiplier for em28xx in bulk
transfer mode is 256 * 188 bytes. This changes the size of bulk transfers
to maximum supported value and have a bonus beneficial alignment.

Before:

After:

This sets up USB to expect just as many bytes as the em28xx is set to emit.

Successful usage under load afterwards natively and in both VMWare
and KVM/Qemu virtual machines.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Reviewed-by: Michael Ira Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/em28xx/em28xx.h
+++ b/drivers/media/usb/em28xx/em28xx.h
@@ -191,7 +191,7 @@
    USB 2.0 spec says bulk packet size is always 512 bytes
  */
 #define EM28XX_BULK_PACKET_MULTIPLIER 384
-#define EM28XX_DVB_BULK_PACKET_MULTIPLIER 384
+#define EM28XX_DVB_BULK_PACKET_MULTIPLIER 94
 
 #define EM28XX_INTERLACED_DEFAULT 1
 
