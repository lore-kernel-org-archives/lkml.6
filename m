Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+kP9qBAtkeQsi5MyvpPce2L4wLXyyiZfwTGAWdRav0c6FcsAAVLmG1e5c3owPWfUNcXftE
ARC-Seal: i=1; a=rsa-sha256; t=1522855981; cv=none;
        d=google.com; s=arc-20160816;
        b=MG/5bQ8cvUW8lYO19jwWvs2+94g73jB0+j2vLJXWzS1+Wpp3nZFv7q0769QGw3bnLJ
         uePFKP7Repx9HWAqYe6o5aGvSZ3pizt9ynmg6Beat7F017vL/jNlDmwqwkGDX8bUxhDr
         axvOgA0ryNaDfzlFz3i2GLRCq1ILtPTbtZS2MCZd7dXnsAiioDpMicjyaxfVp1HgHHwI
         oqTihwAHQgbfBRwhGkGISZncrX+XZNYRfRUP1pCSyGtEnaGMuLpVSUMkWUosFPMEtYHX
         FOHfr99do054nVEKuCIUwjh5UVDxuaySJAOrVOpnu2W5ZnEZw5i98ZyFOmJ1sR4h94VH
         HisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :from:cc:to:subject:arc-authentication-results;
        bh=HcnLIp2gM6bDx62M9XMae0HWInXhYpRfwonGwC9Y+Go=;
        b=eJrsePwX1+71ppTLllRIkcBuRdAMPJpaJJzXw6Zv0tAzCoD8gKYUcKbib9sfSUDcgQ
         Yj8WlVYMECgv7zLTYX9uZk+t/nVU8gimGspavo9ec7SdyFQy7j0cd2m+sxxIeJuFQAPW
         OZuGW020OFGZN4Il5Qq0uxHsa/rq0a5SYYxmUxk9Nn5VECVcv21cBN3NWfzNFNi08NYJ
         1jYvedgM5/IqbttOBl/kK4zANbF9ezNzkQRk1wFzxjk8lSR5f0hEmAGwYwpMr7slvTDY
         Z3Yij7zA4eCzFXNcGPzRlwgCHFckhw2lFBW8DMu2rkTuqsWQGti64+Tc6jCKX13UT2o+
         9CDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Subject: Patch "media: v4l2-compat-ioctl32.c: don't copy back the result for certain errors" has been added to the 3.18-stable tree
To: mchehab@s-opensource.com,alexander.levin@microsoft.com,gregkh@linuxfoundation.org,hans.verkuil@cisco.com,linux-kernel@vger.kernel.org,linux-media@vger.kernel.org,mchehab@infradead.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Apr 2018 17:32:46 +0200
In-Reply-To: <9d0bb62c2dc7caee1fd2b9199fc1a22ec8479395.1522260310.git.mchehab@s-opensource.com>
Message-ID: <152285596621542@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596830233555552249?=
X-GMAIL-MSGID: =?utf-8?q?1596830233555552249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    media: v4l2-compat-ioctl32.c: don't copy back the result for certain errors

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     media-v4l2-compat-ioctl32.c-don-t-copy-back-the-result-for-certain-errors.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed Apr  4 17:30:18 CEST 2018
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Wed, 28 Mar 2018 15:12:32 -0300
Subject: media: v4l2-compat-ioctl32.c: don't copy back the result for certain errors
To: Linux Media Mailing List <linux-media@vger.kernel.org>, stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Sasha Levin <alexander.levin@microsoft.com>
Message-ID: <9d0bb62c2dc7caee1fd2b9199fc1a22ec8479395.1522260310.git.mchehab@s-opensource.com>

From: Hans Verkuil <hans.verkuil@cisco.com>

commit d83a8243aaefe62ace433e4384a4f077bed86acb upstream.

Some ioctls need to copy back the result even if the ioctl returned
an error. However, don't do this for the error code -ENOTTY.
It makes no sense in that cases.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -943,6 +943,9 @@ static long do_video_ioctl(struct file *
 		set_fs(old_fs);
 	}
 
+	if (err == -ENOTTY)
+		return err;
+
 	/* Special case: even after an error we need to put the
 	   results back for these ioctls since the error_idx will
 	   contain information on which control failed. */


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
