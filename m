Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+SvGTaY2LaasA/Au2z/OY0gdyyimqyRBXLnFjOc9Dz9nDvWiY2YpYSGFVU6CPDz/XQE8Cb
ARC-Seal: i=1; a=rsa-sha256; t=1524405389; cv=none;
        d=google.com; s=arc-20160816;
        b=DAYhOi0aUy7oNuwfwC0EgBlZYVX036DzT2i7sXlY7QKamTy0mVrxCBXWMq8h/L39V/
         3Q3CmMY45V1NBQ+XlL13RI3oQE3LxDpfebqgdYuX2wUO0OPUHllrnA9oVgnZslW6qssC
         VGmIyskOdOfDpyAnGJNWEOdhwzb/AGEsZ50Afv/0skcuAnyqB48NWSuT7PQzGtp6rzbj
         IDYL+fYSv6GtLQRtmfowVNan1jw//25INKZThyrgd5ghYdUFeC1TDHgmueBWrXFMF6Qb
         vaXl3M3oEtNtE32NdLAF4lBvCGYbvjg5nnS4D/+zqxPcN9v+jG1QBaIrjpRlGQ/6tuaL
         ghSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hR+YIDytll4nG0ek4xHRwy3gU2coG6VYA4UcEhF/i4w=;
        b=FtwSCqCu1FnwMjIW3Ey9Bfl91p3WQPuy37Y6ZaeZuS5e52TkhgJI2P9j9oH3Llk1RN
         qRX+vK+kJEyrhaL/YQ0emebIBWSsB4roSTnZkREYeSe05WCKDqEDsSFuNazOuxuxEdWa
         30NXQDiGzwQF3sJi5R1PuuKvvDTN6SA25W5qn2pZD4w5HmIT8yJr2hkqpvDPa/qTxkO/
         w/uxpwE/lia4biamp1mUWY/IQN9tuN0pn1siznpybaqQSA7t/21b7vbKYv6udm5J20f0
         KlxKLysAtwM08pV/+VIacdXrOjY0qFBAaV1Slgo4ypqn4sX33EJe93aj1nTF2IuKjAEc
         RFgA==
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
Subject: [PATCH 4.16 014/196] resource: fix integer overflow at reallocation
Date: Sun, 22 Apr 2018 15:50:34 +0200
Message-Id: <20180422135104.884692485@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454905898680700?=
X-GMAIL-MSGID: =?utf-8?q?1598454905898680700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -651,7 +651,8 @@ static int __find_resource(struct resour
 			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
 					size, constraint->align);
 			alloc.end = alloc.start + size - 1;
-			if (resource_contains(&avail, &alloc)) {
+			if (alloc.start <= alloc.end &&
+			    resource_contains(&avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
