Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48148KZkn4RqPTSjHblbonilH19U5u5QlojvBMXx+nZbJtJ41KzESYR5lShnf0fO2uNlqOL
ARC-Seal: i=1; a=rsa-sha256; t=1522855992; cv=none;
        d=google.com; s=arc-20160816;
        b=ahtS/oseLWnr15w3noqkxqV+6Ozn/Ekf/BuQ5KTOa2/CjZQBIkymftbhBeWQTBTlbl
         AkePIOZWIy6raxpgfq1xUufl4as/S286xT9dEjIiE48HBz1hiyvDBhYfBr8dXatekZel
         KIgAISirPao0O4F6sxS4HVfn12hpzRacYsyCumBQRGvVHHSbHbmbGfu7yNJaNMmn9+Fk
         lLYNva1+l0c+n4peKuEj/I71Xl50kH4qKaC82vTqRD2zJHc5SsP8vzOGdvNzQCkGdkys
         k1OSRgwMQvhzF4SKtRDm7kBWbl8Uha3y5ffCBSFQNNM224NEwD9ZUvEmboNiQaEd+yRn
         wuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :from:cc:to:subject:arc-authentication-results;
        bh=SpvqoXprzKRc1emu0jezmuK9aj9P+rIAIASaoApm8dQ=;
        b=0cl24Hx952G983NfqHdHlrIrsOfAQ3djbmaLN+GOUSVP3am5gDmP6vQETmnDgrJHNA
         lOL0x6A4DsZpSFkKFBemojhCtYzR/+Tz6O4c4kdlSBmUVDSpHO8f8o9ih60kL0ysrxKP
         ANl2yspt0P/7ehcuqJixJIiqSrGiJMFZxcikRRMPwk6e9wmC44dnZB0NCAj2VKuTyeiw
         +lkkFgeL/2LdUo5yNmi3P64x2iMXBfc/wk0lOZ1KPCCK13UrD31VPSIwFv4Dt3wzMWm8
         OR9nYQNUYOt13vRk7EVrwxMrLgHHPZQqmgeOM83r9UdL31WTN5sDtiaSK97lWGjrEXxQ
         x/eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Subject: Patch "media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs" has been added to the 3.18-stable tree
To: mchehab@s-opensource.com,alexander.levin@microsoft.com,gregkh@linuxfoundation.org,hans.verkuil@cisco.com,hansverk@cisco.com,laurent.pinchart@ideasonboard.com,linux-kernel@vger.kernel.org,linux-media@vger.kernel.org,mchehab@infradead.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Apr 2018 17:32:51 +0200
In-Reply-To: <39d6997be9988f81bce42a00115b062aac7b0a51.1522260310.git.mchehab@s-opensource.com>
Message-ID: <1522855971155253@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596830245888021649?=
X-GMAIL-MSGID: =?utf-8?q?1596830245888021649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     media-v4l2-compat-ioctl32.c-make-ctrl_is_pointer-work-for-subdevs.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed Apr  4 17:30:18 CEST 2018
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Wed, 28 Mar 2018 15:12:28 -0300
Subject: media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
To: Linux Media Mailing List <linux-media@vger.kernel.org>, stable@vger.kernel.org
Cc: Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Sasha Levin <alexander.levin@microsoft.com>
Message-ID: <39d6997be9988f81bce42a00115b062aac7b0a51.1522260310.git.mchehab@s-opensource.com>

From: Hans Verkuil <hansverk@cisco.com>

commit 273caa260035c03d89ad63d72d8cd3d9e5c5e3f1 upstream.

If the device is of type VFL_TYPE_SUBDEV then vdev->ioctl_ops
is NULL so the 'if (!ops->vidioc_query_ext_ctrl)' check would crash.
Add a test for !ops to the condition.

All sub-devices that have controls will use the control framework,
so they do not have an equivalent to ops->vidioc_query_ext_ctrl.
Returning false if ops is NULL is the correct thing to do here.

Fixes: b8c601e8af ("v4l2-compat-ioctl32.c: fix ctrl_is_pointer")

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -600,7 +600,7 @@ static inline bool ctrl_is_pointer(struc
 		return ctrl && ctrl->is_ptr;
 	}
 
-	if (!ops->vidioc_query_ext_ctrl)
+	if (!ops || !ops->vidioc_query_ext_ctrl)
 		return false;
 
 	return !ops->vidioc_query_ext_ctrl(file, fh, &qec) &&


Patches currently in stable-queue which might be from mchehab@s-opensource.com are

queue-3.18/media-v4l2-compat-ioctl32.c-copy-m.userptr-in-put_v4l2_plane32.patch
queue-3.18/media-v4l2-compat-ioctl32.c-avoid-sizeof-type.patch
queue-3.18/media-v4l2-compat-ioctl32.c-drop-pr_info-for-unknown-buffer-type.patch
queue-3.18/media-v4l2-compat-ioctl32-use-compat_u64-for-video-standard.patch
queue-3.18/media-v4l2-compat-ioctl32.c-add-missing-vidioc_prepare_buf.patch
queue-3.18/vb2-v4l2_buf_flag_done-is-set-after-dqbuf.patch
queue-3.18/media-v4l2-compat-ioctl32.c-refactor-compat-ioctl32-logic.patch
queue-3.18/media-v4l2-ctrls-fix-sparse-warning.patch
queue-3.18/media-v4l2-compat-ioctl32.c-fix-ctrl_is_pointer.patch
queue-3.18/media-v4l2-compat-ioctl32.c-move-helper-functions-to-__get-put_v4l2_format32.patch
queue-3.18/media-media-v4l2-ctrls-volatiles-should-not-generate-ch_value.patch
queue-3.18/media-v4l2-compat-ioctl32.c-don-t-copy-back-the-result-for-certain-errors.patch
queue-3.18/media-v4l2-compat-ioctl32.c-make-ctrl_is_pointer-work-for-subdevs.patch
queue-3.18/media-v4l2-compat-ioctl32.c-fix-the-indentation.patch
queue-3.18/media-v4l2-compat-ioctl32-copy-v4l2_window-global_alpha.patch
queue-3.18/media-v4l2-ioctl.c-don-t-copy-back-the-result-for-enotty.patch
queue-3.18/media-v4l2-compat-ioctl32.c-copy-clip-list-in-put_v4l2_window32.patch
queue-3.18/media-v4l2-compat-ioctl32-initialize-a-reserved-field.patch
