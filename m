Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELswTOFb1kMYVv/Z9nLEzyCkvD7UvFyuem53xT//G/SMJxC/apm8auKV21bVDzJFx0312kr/
ARC-Seal: i=1; a=rsa-sha256; t=1521484020; cv=none;
        d=google.com; s=arc-20160816;
        b=t2vcRhhQ9NXBcgGIMcGkZ9jAreCbypkiCY5jNrmtFiCNfpKU0p3w4J77pNXOaSZxZq
         QdPFGtPS6YvvdZ7+ufphW49RMQLWtUnrTNbG3cvfsjEDCIUgdsqqjp+c59b3WE5loWoi
         YB/EJvZvK2O1Om74av7vaSAZlfhZAPIDIkQvSgfAN3NUjZmtbmpBTQKGEuF9mvIPXKD6
         WxtKfFX1CkMxULfcjniTjf2o0VvgI6ck/+Eeqv4IaUpMYnaW6FacBP/+4bVLuC7IbxC5
         opxU3MtaW5NWd/gGpwJXkzS2UKvgRBl2hyPOKPU5roKguFQS9rUSZ1bUlKdPpzYjY30Q
         xX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QvJ6qyqWq65wbrJtwlWTFn43ivQpoQV9OWmzS3gKEoc=;
        b=JJIOBYR87uBhkG+PsQtSXszvj7LxY8TPDzjz+/Rs8O2HvCdEjtbsQaZz3zLcgsml8H
         k1p3KbOh5DqJXNmEYtYSlwkfRcaG/2UX2utJjdhtVL3RivfelFds7OX4hDgpDI6o7tsD
         ojQsjiKzVdWWw/dphWCtOdO/rLmnqMMPYcBIUllEA6HVfdo199+KA2jfuiPm2g0BIqiK
         uPGyLu7m4h70XYi6L9vc6ceaSMy3TnHnLTZ5lQN2nQCxX0Vv31Du+Ub791cggMmkKxZK
         o1angOwJPOJFSQfYYxXpCWQktk0wr/C2aHiLYZDtF/BUqgOwOQws/5nvEhk7LroYIOZm
         L/hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Mika Kuoppala <mika.kuoppala@intel.com>,
	drm-intel-fixes@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 202/241] agp/intel: Flush all chipset writes after updating the GGTT
Date: Mon, 19 Mar 2018 19:07:47 +0100
Message-Id: <20180319180759.545315079@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390961971643504?=
X-GMAIL-MSGID: =?utf-8?q?1595391628259057096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>


[ Upstream commit 8516673a996870ea0ceb337ee4f83c33c5ec3111 ]

Before accessing the GGTT we must flush the PTE writes and make them
visible to the chipset, or else the indirect access may end up in the
wrong page. In commit 3497971a71d8 ("agp/intel: Flush chipset writes
after updating a single PTE"), we noticed corruption of the uploads for
pwrite and for capturing GPU error states, but it was presumed that the
explicit calls to intel_gtt_chipset_flush() were sufficient for the
execbuffer path. However, we have not been flushing the chipset between
the PTE writes and access via the GTT itself.

For simplicity, do the flush after any PTE update rather than try and
batch the flushes on a just-in-time basis.

References: 3497971a71d8 ("agp/intel: Flush chipset writes after updating a single PTE")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Mika Kuoppala <mika.kuoppala@intel.com>
Cc: drm-intel-fixes@lists.freedesktop.org
Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171208214616.30147-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/agp/intel-gtt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -871,6 +871,8 @@ void intel_gtt_insert_sg_entries(struct
 		}
 	}
 	wmb();
+	if (intel_private.driver->chipset_flush)
+		intel_private.driver->chipset_flush();
 }
 EXPORT_SYMBOL(intel_gtt_insert_sg_entries);
 
