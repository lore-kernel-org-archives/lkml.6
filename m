Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsjdozHpZWhFOfRILuUpEsUemkwm9dDXa3W+LvooDjrnOf/RAhjUXZvD/HUGzLxqvV5w2zA
ARC-Seal: i=1; a=rsa-sha256; t=1521483736; cv=none;
        d=google.com; s=arc-20160816;
        b=kl4rXT2z27XdRjTetSryu2ooOILORGQ4ZRT/k0adRyuISmADy4Jhqd8NbvdqePTqJt
         knIPjYuF6/g7CBVOY1qeNh0T6YMCMT2CQWeK3O53wmoH/xaj/s4WJFluYrYPiWglVLni
         WL3uvZduDUgSQSJGusAwGjv5QaKYdz8EFFuWO8E4UoXV7yXIW7S9M2YamALoUATj3ZhZ
         dPisRNrcElnLlj035ZU6l985xCfti17BCMcs9YFFt3jT3jTzqrGyeBMDsNfiCjjDhYHr
         YTdDEbFiNcuxFd6NZ2cCVB6lCI9bpglfEj0AknaAIr3bfYTrH+JrAuZ5gjOcHuAS97C5
         c5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kw2cvn1T2oRYJNf+TtIgd/qh6vrXCQv5grCyc8r5dWc=;
        b=jPdnw+u0FBda0NoKlhEPyzYGozJ8lQrnLCAMkzIYpBlyTNely9YPp9l7yHu5YgXYGE
         /dNLvG+FyiT6l34pPqtsz/LLYdEDqiyPW/t5PSfG3sln7S8AhscejXCJMWXY4W0/5BZG
         fKf/QhEcN9JMxl67klDghmNnHCUwIZq6pBvdk4esmi9Jh5x+MBmkVqnhbnzg6d5TXEfe
         2DrKDgeJySs+JqTQ7wPN3jViblAjdmhN3j93VokPfRG7jeAGMLgCk0K8VxM6j9HEfsmO
         3JZD65i8Uw3Kf3f9wbuLEp4D8XyY2unHvADwetHGGkPtj84uqedTIwwzTOTg7hwefE7j
         6kJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anton Blanchard <anton@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 097/241] powerpc: Avoid taking a data miss on every userspace instruction miss
Date: Mon, 19 Mar 2018 19:06:02 +0100
Message-Id: <20180319180755.209904834@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390545850143108?=
X-GMAIL-MSGID: =?utf-8?q?1595391330787669104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Blanchard <anton@samba.org>


[ Upstream commit a7a9dcd882a67b68568868b988289fce5ffd8419 ]

Early on in do_page_fault() we call store_updates_sp(), regardless of
the type of exception. For an instruction miss this doesn't make
sense, because we only use this information to detect if a data miss
is the result of a stack expansion instruction or not.

Worse still, it results in a data miss within every userspace
instruction miss handler, because we try and load the very instruction
we are about to install a pte for!

A simple exec microbenchmark runs 6% faster on POWER8 with this fix:

 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>

int main(int argc, char *argv[])
{
	unsigned long left = atol(argv[1]);
	char leftstr[16];

	if (left-- == 0)
		return 0;

	sprintf(leftstr, "%ld", left);
	execlp(argv[0], argv[0], leftstr, NULL);
	perror("exec failed\n");

	return 0;
}

Pass the number of iterations on the command line (eg 10000) and time
how long it takes to execute.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/fault.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -294,7 +294,7 @@ int do_page_fault(struct pt_regs *regs,
 	 * can result in fault, which will cause a deadlock when called with
 	 * mmap_sem held
 	 */
-	if (user_mode(regs))
+	if (!is_exec && user_mode(regs))
 		store_update_sp = store_updates_sp(regs);
 
 	if (user_mode(regs))
