Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224QaswOrTtxmhKwxPTYbraSng3OGbPancK258FeMvCPr6pDOfV5vgdrm0J0Jv5BlnHkaX5S
ARC-Seal: i=1; a=rsa-sha256; t=1518708449; cv=none;
        d=google.com; s=arc-20160816;
        b=JBRgjF4lub8K5Al1TCuVplmLZIpXmwPgnP6MkncC2sJgU4b85fRm0MX5uZB1cWnMkv
         YUkN4wLiLQtPMOx2X8JoXaZlhnokPhsL8FFxR95kjeZpcLAf8ZKZBvqw5k5mAWnxlWRo
         BHDCI70xDrxTLOhPcLSAMMrVdSkHKU9yd2zRlHGbqecqcKO+qzprCb631tv86iNOIdbM
         lRXD/NLPwsynkkZKGNhusq5UbwazYYF/JnvBjjtA4of0nOe70oE/ypWRSg6AHnseGEXI
         IQkFpJVFH6Tj8f8p0whkx64zYwKDtU2Hg6mzF3r9VgVHn4GE12GXlAnW2eg5BtlGSYyH
         Jszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zFnSD1p43pKm+h5n89+YJhVysZkb5cXsRGjlCGRDBtM=;
        b=sk//gGGQCFv96bnTbbWl4X7JvF1HeE7Dg/KkCQfjpFG+/UOwV92FgT6wMwsU2UziZ6
         5i7WM4CYt5iGQPMAJ4TW57XG8NTdsvMgwlG8SCbQgOEyG1t2TF3FA3XnVjiLlCt91gmI
         wT2T+DXM9bgLUUM5iW6LrS8UyqNevxbU4pApMDrhZIWUAi8U8a9Em/Pn/f67uik/Sj6n
         HGYW8wIx5Q1PD4uHLbFLyEDbhvWxfz4XfWpfThSINfmMLvEPNozv+pkoJP1s02GpOgl/
         kU+ps4/HHGQlcd1rKVnGVwpR2aexIstHk2pkHdOj09QU8kugPtf4Nb203lMZvKCbTDqI
         qS7g==
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
Subject: [PATCH 4.9 46/88] media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
Date: Thu, 15 Feb 2018 16:17:13 +0100
Message-Id: <20180215151229.071987947@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481022948715937?=
X-GMAIL-MSGID: =?utf-8?q?1592481231681263945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 169f24ca68bf0f247d111aef07af00dd3a02ae88 upstream.

There is nothing wrong with using an unknown buffer type. So
stop spamming the kernel log whenever this happens. The kernel
will just return -EINVAL to signal this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -175,8 +175,6 @@ static int __get_v4l2_format32(struct v4
 		return copy_from_user(&kp->fmt.sdr, &up->fmt.sdr,
 				      sizeof(kp->fmt.sdr)) ? -EFAULT : 0;
 	default:
-		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-			kp->type);
 		return -EINVAL;
 	}
 }
@@ -226,8 +224,6 @@ static int __put_v4l2_format32(struct v4
 		return copy_to_user(&up->fmt.sdr, &kp->fmt.sdr,
 				    sizeof(kp->fmt.sdr)) ? -EFAULT : 0;
 	default:
-		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-			kp->type);
 		return -EINVAL;
 	}
 }
