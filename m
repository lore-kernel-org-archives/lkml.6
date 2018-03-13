Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsTsjo9+Y55OT1dUMuxtBIkbXVBqYVgzC/856/7EPQPJY/JH6+gFtyJfPmCnMKK+QWCG9iG
ARC-Seal: i=1; a=rsa-sha256; t=1520954868; cv=none;
        d=google.com; s=arc-20160816;
        b=QXa3NFE3yczW1s8EOfbpbcEGJPOuYafwRXQuisu1Ea3QG35KzUjoGiCtPFsjW1HsYi
         LF6sTwlkerUCD+7AnzE/YZODo1lfX2yw/CFMkQCq44OK2TC5Twrl6NtO7kPJWXg3F/KI
         XJkDiOeIz4OuuspBfIHeC0XABjTZCpIcDP+WHM1vuJ6g/xSaysoh2VjfAbc0HsAoHTJT
         A582BLTbCT6rNwKjR2gu5RxjIoRveWcXLi6vcxCMo1DWGjEnATkp+8C0qrO5x2y4c14X
         09JoB9M/7atcVMrurOJ2ua6g5qha9Wd+RGIys0N+m7ChjPNRUr7RzHRmLKzK0+yIOjF/
         r4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fl5HsHLbKLAYdc/W3l+4d56kmiD7uG77cDA7IUmAzHU=;
        b=f6WdnU25HUg59iwY6v9AEAr/stM8KAnuC+V3BtJhvyVagIbBNFAqlEOeWebjdETbOS
         UxE4zf4xVS2QYvWiWtYtLyxe66MFmReUOjBHX/inAoMWpb/nauDxfc04XrU37OQEklnE
         u0xxhMlVBWzwYYJG5BAwP1+KM8zCMZpHJX/SCA/TlBn+dYx8d5MBxDt5yMh7xsYUfpM7
         9P4P1tzxqUXgLUwycwe9vLRZxRayOpuWGTkVz+tpZP835d7Eaklz1OcPI/UjybWk7yj4
         /9tLUfzPVTHbzHxst2Z5Az6ym0Ff6iW01h202JJEJ5nJeNd7Rg+nJIEWZUKNQLgkv+nw
         FY7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.15 011/146] drm/i915: Fix rsvd2 mask when out-fence is returned
Date: Tue, 13 Mar 2018 16:22:58 +0100
Message-Id: <20180313152321.479544833@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836771599824180?=
X-GMAIL-MSGID: =?utf-8?q?1594836771599824180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

commit b1b13780ab06ef8c770dd9cbe31dac549a11630e upstream.

GENMASK_ULL wants the high bit of the mask first. The current value
cancels the in-fence when an out-fence is returned.

Fixes: fec0445caa273 ("drm/i915: Support explicit fencing for execbuf")
Testcase: igt/gem_exec_fence/keep-in-fence*
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20180214191827.8465-1-daniele.ceraolospurio@intel.com
Cc: <stable@vger.kernel.org> # v4.12+
(cherry picked from commit b6a88e4a804cf5a71159906e16df2c1fc7196f92)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -2419,7 +2419,7 @@ err_request:
 	if (out_fence) {
 		if (err == 0) {
 			fd_install(out_fence_fd, out_fence->file);
-			args->rsvd2 &= GENMASK_ULL(0, 31); /* keep in-fence */
+			args->rsvd2 &= GENMASK_ULL(31, 0); /* keep in-fence */
 			args->rsvd2 |= (u64)out_fence_fd << 32;
 			out_fence_fd = -1;
 		} else {
