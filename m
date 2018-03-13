Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtT1Br1RbfDnojDZJ94xYrBk50ZQGDk/yHqH9q+r1vYTS44b1nVX5OpkfnJRcagFzGPUnyx
ARC-Seal: i=1; a=rsa-sha256; t=1520954984; cv=none;
        d=google.com; s=arc-20160816;
        b=yZVlhdYBufZmuWasqGccU27XjKLFf4WojB5CuYh5xFC5uUMBS4+ZTrJn6pUXL2PizB
         PgbBk5Cnk/v/pXrK9U82o7PEPVqYOluoKMrXwAFf3Nz5tAzUULK0IDqd9aW18VxN4D7Z
         44ObUZrDwhRu0BV9qaLkRiCSU8DuIN88Ha7Uf4FVcKeSHON40STSUryrkHqP8LiXRude
         Or4qdI+YQAgZmeVUIK3iYQOqQ9Pvk3lvrc/JxqvSx/n09jmFUCHeGCA9W6sskAEFFMA3
         6t4/OuvuJvmw1y/H7q55a8pWryh6LHgHsGzNGSoV83uxnG5v9zbljLqAUskykoyqXZ/R
         DuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cEm9o8V72qXTIZak7w+b6DVtyiVIjFnjatIzFoPxjsI=;
        b=IwWFV6FhNRu1joOIRmY26O9UwM2I/W2evQzLMmoTEOv8utLiUj6mctCdlDiEUuqpGg
         3ZQsvofFkq7iJxsoxePCxYY5V8T+Nby3xseyO5QzhbS8w2N18DsGzQAKBxdPqCllNVEL
         czU+12A2kja4KpsgH6IrA5E3pvvLfwV/CJs7vMTetlVIP6NJ2TIaWM3XCX5J2tIwCdgH
         3B2bTdUdGWqO0kWcPfjhAxzy1LfXDSAYaxZK3yjIUP2KzMhxbNfqlVr9LMGy56YM4K7V
         KauVos/4B2wpg0gUIQtsYKEEIzPDDSZBxTt9UQDSqSiyci2EVaCH5GwII1YLcVRIESST
         3itw==
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
Subject: [PATCH 4.15 012/146] drm/i915: Clear the in-use marker on execbuf failure
Date: Tue, 13 Mar 2018 16:22:59 +0100
Message-Id: <20180313152321.544455353@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836894035930650?=
X-GMAIL-MSGID: =?utf-8?q?1594836894035930650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -505,6 +505,8 @@ eb_add_vma(struct i915_execbuffer *eb, u
 		list_add_tail(&vma->exec_link, &eb->unbound);
 		if (drm_mm_node_allocated(&vma->node))
 			err = i915_vma_unbind(vma);
+		if (unlikely(err))
+			vma->exec_flags = NULL;
 	}
 	return err;
 }
