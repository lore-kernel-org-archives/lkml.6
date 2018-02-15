Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225HA47VWdVGoEOE/eRhcUUEqUjS81JR3VU7Po4IaRSmxX5fyCPxiiOCR+SK/IIpvpuDeU8a
ARC-Seal: i=1; a=rsa-sha256; t=1518709028; cv=none;
        d=google.com; s=arc-20160816;
        b=0CmC+S98rvrFrAwbFcskXghBGVy/WgJSgaLvOhxen/ni8+5KFrKPAG/nKFEbMj1gSK
         OBavhoryhLr9LpQXgDKfn+yet+o0Plv3GJ9lZNQeXquHlyAZNg8HGJTHZPigwNPX/6X6
         rGHJ6fY4nHNBfA/6w7QorafyvFTgf/tMuuS9ZejFIF2F/fsv3u1wEbCzmyWTnFmg49V9
         Ubm0+QSOUChNmxlOb/0E1rjrBI3CKOCgew0/McKtxYzn4VzvqhJ1beaWXGWFaWa3C/P/
         0nfx1FTKoCjdk98rRs0z+EBSln+ReH4HDwlcu5DmxEX+TMPW8sBVZEDCsYvcLukFxsrU
         r89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oFfi7fIDgjWNOIOfuA+DuTv+xn548QXGmshoi7PYeT4=;
        b=qstaLQl344w5A1wNTfbhTYhh7RdmjJR0DzyyoBTzA5kB/R74yXpDrAd66hZwu8LcOk
         FE/v/Rg8jg7cOxALhFCdO5xMsU+KGJ++tGnssIv7Gh6enSExkBixYbaWzHgL4M5YZNqw
         wDtHnav2gSJdzMvNnPX3fauDFpV5fM0k3r8fZUW3hFV1HJ528U6lBL0Hst6CUwX8TX/G
         gZJkwMT6sNdBKlvqudj/nxf3RsObRH5P/8o9nOD4jUg7b8/Uvh4ShimtnT4J3cERa8Tm
         tRX0XMxuykp13npd2ve9IwX9Fz2HqihOmhSS4AHs3NnkN/hud7leUgXy/wbq+OItpD38
         K0zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 121/195] media: v4l2-ioctl.c: dont copy back the result for -ENOTTY
Date: Thu, 15 Feb 2018 16:16:52 +0100
Message-Id: <20180215151711.759666809@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480999261182610?=
X-GMAIL-MSGID: =?utf-8?q?1592481838761210908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 181a4a2d5a0a7b43cab08a70710d727e7764ccdd upstream.

If the ioctl returned -ENOTTY, then don't bother copying
back the result as there is no point.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2892,8 +2892,11 @@ video_usercopy(struct file *file, unsign
 
 	/* Handles IOCTL */
 	err = func(file, cmd, parg);
-	if (err == -ENOIOCTLCMD)
+	if (err == -ENOTTY || err == -ENOIOCTLCMD) {
 		err = -ENOTTY;
+		goto out;
+	}
+
 	if (err == 0) {
 		if (cmd == VIDIOC_DQBUF)
 			trace_v4l2_dqbuf(video_devdata(file)->minor, parg);
