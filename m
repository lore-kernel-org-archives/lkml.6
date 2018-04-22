Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Gl5K3cyIN3k1sQUf7Luy5EaKvTqJszlWHFANT06d0UUyHdLzFqeID/1doUGObv3iK6kYJ
ARC-Seal: i=1; a=rsa-sha256; t=1524406579; cv=none;
        d=google.com; s=arc-20160816;
        b=d7GlANaVyRFpwqas6SkJr1cIXXENOQXTAC6yjEm1qN5QJbat6Nsnn77TrKNSo+7fCw
         vPkADivnNgw1eaGb1nvCdPN81ecFVDO9GRFvL0+NflDQDoLDC4DbFyxedNruuFGauI8Q
         t4P/wCSSlFDhLVgk+cNzEI1pZaylXdCQ3JWP9zgJa7KQecyb/iU0u7GQ+IMBNfMNT/54
         6ydDG2WTZ1zIh/QhLXajKEqSfeWtR2LnPOu1iEegvhA0nbecGvTkUrZ4ocQt8/q2cyhO
         0yS+uRr6kc2HFOgE6Ub6HOFnuTOvBjc35+4dKsG/y8Y15wFzzwF8LjuuKGpWG/CXTHhK
         ZDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RHdOZAwis48/KPL4f2W1j59gbVP0tvp9FNkh79hMRQE=;
        b=fWP2ZtOJqlEP3gBzOMS1JC/YtJnV+IcpF/rsxnEyztZ3poClvw34d3IhF2ZrGD5LmL
         6jgqOjiGpmlhLzDj6k7D44PLvX7arXR+ysXPA3R+oTiR2Y6HowTZrbnGT7/SwU5NnWsf
         gRlSKLxPRzvGtQMKO1dVxq5RprU6woLjx2yo9wjFl5StmRN0BJtNeOSVECclMQIUN8Z5
         hvX3S8d1HynJx6vT1PXleLDUXB6qDhexx2RgtuV1iXNdFI+MtB8h+W9U5fHUj8cH3a0Y
         FqiHujUbbgrsrs9wEdfdwSqr3c4PODY6FG/3JTDrAJKyUeyYzQPsOdprzu1VumxmzLBr
         M7TA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Michael Henders <hendersm@shaw.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 27/97] resource: fix integer overflow at reallocation
Date: Sun, 22 Apr 2018 15:53:05 +0200
Message-Id: <20180422135306.566426180@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454905898680700?=
X-GMAIL-MSGID: =?utf-8?q?1598456153984481123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 60bb83b81169820c691fbfa33a6a4aef32aa4b0b upstream.

We've got a bug report indicating a kernel panic at booting on an x86-32
system, and it turned out to be the invalid PCI resource assigned after
reallocation.  __find_resource() first aligns the resource start address
and resets the end address with start+size-1 accordingly, then checks
whether it's contained.  Here the end address may overflow the integer,
although resource_contains() still returns true because the function
validates only start and end address.  So this ends up with returning an
invalid resource (start > end).

There was already an attempt to cover such a problem in the commit
47ea91b4052d ("Resource: fix wrong resource window calculation"), but
this case is an overseen one.

This patch adds the validity check of the newly calculated resource for
avoiding the integer overflow problem.

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1086739
Link: http://lkml.kernel.org/r/s5hpo37d5l8.wl-tiwai@suse.de
Fixes: 23c570a67448 ("resource: ability to resize an allocated resource")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Reported-by: Michael Henders <hendersm@shaw.ca>
Tested-by: Michael Henders <hendersm@shaw.ca>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/resource.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -611,7 +611,8 @@ static int __find_resource(struct resour
 			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
 					size, constraint->align);
 			alloc.end = alloc.start + size - 1;
-			if (resource_contains(&avail, &alloc)) {
+			if (alloc.start <= alloc.end &&
+			    resource_contains(&avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
