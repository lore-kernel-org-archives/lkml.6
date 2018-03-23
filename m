Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsRyDixb9uuCwG4V2XRBpLRfKlKNDMZwWwmc5vbtKD6k+ffAL2rLNV9nPvV/YWUe3oKYZrA
ARC-Seal: i=1; a=rsa-sha256; t=1521800198; cv=none;
        d=google.com; s=arc-20160816;
        b=0YcseaS9c6Cp9J7+wqLKYXkH1lUiEScPn0Q/JhWF1bymNQN3fZlI/j9U+ra34y/imv
         HFxM+sfPL8rUpS+DZSxmd9tjqynin/62NsNP1kSmovkTPfFCJ4byWWZvrkqP0wXn/ote
         Ty+gfCHkcMHH3YPLYH8CbEfHb13z4ByvX0xAkub1zH2zMmjhjmr0GNAHVbF/EZH8Q5L/
         YmmDpNsuTyruWqutYov2IeSZtYpDS1gBOCaMJLGCAOsiYlfklLDh8Nt8nh8IXZwWkY+h
         0tRT5Jf8I/8s+eH+aukTZrwhXlCX8ogbJvrkTSzcwr+o3UfkfwrvXrcd7wX0k0uhZUey
         D3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+MmaYh1t6E6UbQvLfCMRqr6gnAs7AfcxDzIPzS8u080=;
        b=dZdPRwM0NBZjISd3uz9NEXeqtR0EcBZgRnSB+6JnYojAsDuD6Qa5wjao1jn/yLz+m3
         l5lVQS9Z8U1tFlSFy9tg3AsMHCKFNDDWqjcdLkJ6hJv1YglPaQpY1BA6w+RZ2wMmlXQt
         sbrJb2JKEaZeMNyvj/uD52Rf/JbDUZitfkBAjgAi0A1t9ZB5FZ2H2RISFxZT2Rm4yvzx
         vOAKsjZiktx8lJw0ar+C8HgFJAm6SrqJOJzryo/WIIaqrs1TTL8VNhinJ90iNeNoKrXc
         HHHcfo083o9doa5VXMOUzzeFSTE9Txi83I3Ynn87gPM2Yp1LkQn+6zgGbf6r0SkngTJY
         8thQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 67/97] sm501fb: dont return zero on failure path in sm501fb_start()
Date: Fri, 23 Mar 2018 10:54:54 +0100
Message-Id: <20180323094201.386632950@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722758223854090?=
X-GMAIL-MSGID: =?utf-8?q?1595723165202796359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>


[ Upstream commit dc85e9a87420613b3129d5cc5ecd79c58351c546 ]

If fbmem iomemory mapping failed, sm501fb_start() breaks off
initialization, deallocates resources, but returns zero.
As a result, double deallocation can happen in sm501fb_stop().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/sm501fb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1600,6 +1600,7 @@ static int sm501fb_start(struct sm501fb_
 	info->fbmem = ioremap(res->start, resource_size(res));
 	if (info->fbmem == NULL) {
 		dev_err(dev, "cannot remap framebuffer\n");
+		ret = -ENXIO;
 		goto err_mem_res;
 	}
 
