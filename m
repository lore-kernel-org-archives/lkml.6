Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvs7VzbQOaopIgucghUGNA70ziL6a3N9ZhTbEwfw1d0c0XSe04Qf03z02T8vnflhMpVaXCm
ARC-Seal: i=1; a=rsa-sha256; t=1520955448; cv=none;
        d=google.com; s=arc-20160816;
        b=nCHJfjCR3MpU0f4olTNjFnHV8qCP9/5jf2Ia5LPHEPOYAcoS4OKXEc8Q4zAdJ9ttl4
         nYWqF6xxh56N3KTGNDIt8mIaD3twnJz0R0wFZyCvQdM9/4aR20SMQ190bz3bekEkZR+x
         S+7iR8m8nQiTi0rpXduKogv7mgSoJaVkr5R/KPieC1H3Cwv+tnoHToih8F/M+BMq3kYO
         EKpBPAJNcNlRHhb0vR9pkdw55EnuDzCh8+OwhwgoImyJ5jDRNfNb1u1wmORXfKJNOKM7
         sjzzp4oW8hOOht4rzopi+xnYSrn8U51zCP8DIfdB0wUDfRX1UvpK+pXe2pBQauzRoiOj
         3sMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PCLkEZc4W03UhBmR5C3yLfNLbC1kMI2EdCvjx+95Nuo=;
        b=PaALwPz13bVCmzPXaimVpX2RoxL7LPxNKbIkWnhDKnd4skscE6BZLfmD4iPXd0bFeA
         YOg4kCSpHZFvQ/5e5cpSLg1V/wFw30j58rDfReidlOgcWfqfkSG5AtwPegwcf5QTjNnY
         wDa/CR/IMps6j0P/lUzT3pvlfzJp5su/rsN37zCSq6TcVXAxhNgjUssK7gA8e9kpdwzm
         kT2EBuL/eUmNwXOsn1YsqbPYoavrVfLqh4cFfexmXkTEeqCmF7rXmCM4IxCiJIcmiVpK
         /ckvn5zfvNPpiZVJ/sLr51ZME0w2zKo9apdP84yWp2G9HBdELYeq6M4cYtO/CpDwEzRj
         xMCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.14 053/140] drm/i915: Clear the in-use marker on execbuf failure
Date: Tue, 13 Mar 2018 16:24:16 +0100
Message-Id: <20180313152501.815279876@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836894035930650?=
X-GMAIL-MSGID: =?utf-8?q?1594837379827263593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit e659d14ed48096f87a678e7ebbdf286a817b4d0e upstream.

If we fail to unbind the vma (due to a signal on an active buffer that
needs to be moved for the next execbuf), then we need to clear the
persistent tracking state we setup for this execbuf.

Fixes: c7c6e46f913b ("drm/i915: Convert execbuf to use struct-of-array packing for critical fields")
Testcase: igt/gem_fenced_exec_thrash/no-spare-fences-busy*
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: <stable@vger.kernel.org> # v4.14+
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180219140144.24004-1-chris@chris-wilson.co.uk
(cherry picked from commit ed2f3532321083cf40e4da4e36234880e0136136)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -499,6 +499,8 @@ eb_add_vma(struct i915_execbuffer *eb, u
 		list_add_tail(&vma->exec_link, &eb->unbound);
 		if (drm_mm_node_allocated(&vma->node))
 			err = i915_vma_unbind(vma);
+		if (unlikely(err))
+			vma->exec_flags = NULL;
 	}
 	return err;
 }
