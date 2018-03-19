Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsqsFsZdiMioIz1trQ9qEPbwdpLy9z2CyegjJGgfUC5fCfBXCeSQyfouW+xat3BQinhlG+z
ARC-Seal: i=1; a=rsa-sha256; t=1521482988; cv=none;
        d=google.com; s=arc-20160816;
        b=rUTGtUbdNMYXaliDGyoa3ie0UOjmcsDBIZ/v22mQVFDES+CWgFZTD/NgjDtfT1sXyq
         VuSP1Az7kTkwr6/L9Mcu+tjpoaB68FjEAam/CBNtRE9rAumQGvBHO3pgE1AxIcrUK9FE
         UseQqnjJ4Uwo8N+cMjWSPlYnbCzh2LRdmM0MUc0Fi3nQ+XewRyneQpz+9doIemDvlP9R
         9mYhkl5c8MaIpEhHOQuCDtpCE4AX/namZ5dMxdqysxczfMHPnWatu6NlI2EmLKPkXVIl
         LrBwAgPvLyAbnOCiU1c0P48y8IjhrLbySiocrj8mimdHA3NsBrVWpBlcVFzsFsMpmXoY
         f+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8O5IL6GhJEqAPoxO2iCwKsdXqe0gAR8TOXpwcj0Oq78=;
        b=CrG8sN1RGRcfDb/LjcUQU8cReNHeiOouMugzYLhmDoyzzlbjUaNqt+zFRBTu5HDWh+
         aOfBF4wAAeJ+DqhnbJoDkZ/Acqa5a1l5rIzwQ9brFiG+qPWEjESHOD+J9jNtZOTfhFQG
         DaXS7O5L7jR5TOzJPL5Gtj85xIZG5IxEnbK9ErWPbwqy8GCW2Sop5PRPH8kcA/MptLTo
         jr8GGO99YvMKazpwvA+XQ5TK3PEtdz9JgmlD66FTwZWKuNZOZsUfPkuwbiJqK9lDATmu
         D041zDpOyzqWJWoCquUFIJzHs94baUeEmKx9RVk8JIJCVAAeD6a2Ov+zOvwe2Re04FZy
         cEQw==
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
Subject: [PATCH 3.18 26/68] powerpc: Avoid taking a data miss on every userspace instruction miss
Date: Mon, 19 Mar 2018 19:06:04 +0100
Message-Id: <20180319171831.528802054@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390545850143108?=
X-GMAIL-MSGID: =?utf-8?q?1595390545850143108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -294,7 +294,7 @@ int __kprobes do_page_fault(struct pt_re
 	 * can result in fault, which will cause a deadlock when called with
 	 * mmap_sem held
 	 */
-	if (user_mode(regs))
+	if (!is_exec && user_mode(regs))
 		store_update_sp = store_updates_sp(regs);
 
 	if (user_mode(regs))
