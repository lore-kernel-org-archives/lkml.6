Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrJYFBK1+9TX6qgwmtUaUUwTbFtJENVTmgVZ0eYUvzck5KJQ8GYcrrqgfsyeWR3h/hpxHlz
ARC-Seal: i=1; a=rsa-sha256; t=1527155857; cv=none;
        d=google.com; s=arc-20160816;
        b=iUpeHV5+MfwIclx9Fm7WXP3SNTeXv3YnhBFd75NakYPelkb7RK6Ifebso9FGWseGnz
         Q556RFirRury/hKoUOGD+/Ma8MiQbCJqlK7uAcbwIgYs+sOKia9U2mDXitDxm6lRI75f
         o39aSrRf3QWmKnIjXL5WBxFv36fVnYm5C61Nhjr5i4Enl3/R/WVfviQgqH1SSwmRtH/F
         b4yQf1SXRc7G+vMUolaI0P3TWXy29VpTWHObX49pxZuj3Qp1HPIA7r9o3V68Ve+YSEIv
         Z2zydEhNutdorINvrZyxbH2syXKcGx0xtqmgE9iTeiYCeTAntRz+SoIYDgys70WDN9G5
         cX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=19SsaNcPLCzu+cOIPmebP8t1P0a2/0GIq4upSz18VHE=;
        b=sJfS5/Tg0MpariR8tS3Gxxzdh6V2zcNF7scOGkizVrIrsE9n7ISyd6S3qJMXw6f8jy
         frwlSrFhReYim0m2KI45e5J2RGLD4nb2U9fU2cEKgIcHRXQeNc2SSMmlTLvMFPlghtjq
         s+cMQMDfLETQ9PRl2DLOJIqI31Prm0JESb224PXxx39z3nuZPP2EbkU6n+dCLXhHInPI
         yNgMwv1SA9GzkM5srm2W9IstDv0HHfVyq0rD/XyASPShze1PpAyATj8z5FgKHf7hLkmf
         nqYRYGCF7hQMZ3LCUMvZ/dO4xFoYwviqV4x82Nj8a+VC1WI2t+ANX1UJjumjSuyGc2uU
         oQyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gRpW425s;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gRpW425s;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 142/165] media: s3c-camif: fix out-of-bounds array access
Date: Thu, 24 May 2018 11:39:08 +0200
Message-Id: <20180524093627.822425622@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338534966239104?=
X-GMAIL-MSGID: =?utf-8?q?1601338981365136690?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a398e043637a4819a0e96467bfecaabf3224dd62 ]

While experimenting with older compiler versions, I ran
into a warning that no longer shows up on gcc-4.8 or newer:

drivers/media/platform/s3c-camif/camif-capture.c: In function '__camif_subdev_try_format':
drivers/media/platform/s3c-camif/camif-capture.c:1265:25: error: array subscript is below array bounds

This is an off-by-one bug, leading to an access before the start of the
array, while newer compilers silently assume this undefined behavior
cannot happen and leave the loop at index 0 if no other entry matches.

As Sylvester explains, we actually need to ensure that the
value is within the range, so this reworks the loop to be
easier to parse correctly, and an additional check to fall
back on the first format value for any unexpected input.

I found an existing gcc bug for it and added a reduced version
of the function there.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69249#c3
Fixes: babde1c243b2 ("[media] V4L: Add driver for S3C24XX/S3C64XX SoC series camera interface")

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/s3c-camif/camif-capture.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/media/platform/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/s3c-camif/camif-capture.c
@@ -1256,16 +1256,17 @@ static void __camif_subdev_try_format(st
 {
 	const struct s3c_camif_variant *variant = camif->variant;
 	const struct vp_pix_limits *pix_lim;
-	int i = ARRAY_SIZE(camif_mbus_formats);
+	unsigned int i;
 
 	/* FIXME: constraints against codec or preview path ? */
 	pix_lim = &variant->vp_pix_limits[VP_CODEC];
 
-	while (i-- >= 0)
+	for (i = 0; i < ARRAY_SIZE(camif_mbus_formats); i++)
 		if (camif_mbus_formats[i] == mf->code)
 			break;
 
-	mf->code = camif_mbus_formats[i];
+	if (i == ARRAY_SIZE(camif_mbus_formats))
+		mf->code = camif_mbus_formats[0];
 
 	if (pad == CAMIF_SD_PAD_SINK) {
 		v4l_bound_align_image(&mf->width, 8, CAMIF_MAX_PIX_WIDTH,
