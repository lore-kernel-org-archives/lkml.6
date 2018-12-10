Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054ECC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F4F2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F4F2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeLJVwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:52:25 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:48231 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:52:25 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mcp7M-1h4zH82xZi-00a072; Mon, 10 Dec 2018 22:52:08 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: eeh_event: convert semaphore to completion
Date:   Mon, 10 Dec 2018 22:51:57 +0100
Message-Id: <20181210215203.1936171-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CJMjen7qL/4911//J/0sv7G7S8E+q/SSejut+uCpjBv4zydQ5RO
 FGJZm0JISlxHEUJ3un5ZM6d/lblujQ0cc7mfpk5qgnF0o1fVKrQ6bKiua+G1KQBdKMoe5fL
 G7+OFz6V1A+U42btvS9HMuIWxgxGCsiq8Pmki2B8KEocuNXTUalCXi3cUWE8c/7Kodg8d80
 5vkkfNGWhQ33oLkjd0Qbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C8Ti6BchASs=:3l1/MrI7K6UnvvcPbHChTQ
 0VQfEHop1SUuai4W7QIUc/mhzm7eT0lDA5K//nlvZ0AmK3hXAoZetaimmNkpvPY6T+uhzXeI0
 l3tlTbpBUygR+3y4sCKYOZ9n74JfsWDfofz1j7EShddUumEU5ytlty63Q1vpTqDs4pTMJw3aV
 VphfSeOSpaYnushWNjiLeUkZCvTaYw77A7BERbSNLeojgkEEljTncfeMqVeXRu5QlJqSF/pJI
 cM0unTIqdTl7bphrC7UsR+VOkychW+pz/vWoSOcF9cnQBBU5kWhZKWs4/B1K2F/G828+kQAxi
 AtdV5zdAY+T6c45/fxbLC+w/nQKMpI6NsZmRczloRqkMFmA+x25yzHyLGFmn9jy0OtmC07/wL
 4l8TzDVeHjdAt9NflL63tIP6GHp62/h5tW40uuHcSNhtIewE0EcjvUoX7TyFibWogR0OiUSVl
 H/VaRJfiODxgsvQedoiu6JrC5w/PhPnKrG7NS/Xef3+jY0VmJ9oaEQfKKR+5/X5Nwt5ckVbH7
 M2F/6XE8bZyIbcPJupzaYXiHpRdCi01+xFE86y2y++qeNboun3f3F1qBL6ah8ZxaSVFjpeHpU
 HCOB3EeIZro8tHCq9K81Cnjj7RBHtPT/qw3fgGl2AS/vkf+uNHeKvFlo/49FmIbDJChdHu3ev
 C/27QfazrZJg+diAz926M9fIeFZRFC/YWXp6xKc0jH2N5NDfA4d8GBYNnq8Lgs7DAkIm3GSda
 IN2gdqNkvufxxjUADucwW4HgD1FNn6dTbHQn/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For this use case, completions and semaphores are equivalent,
but semaphores are an awkward interface that should generally
be avoided, so use the completion instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/eeh_event.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 61c9356bf9c9..227e57f980df 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -35,7 +35,7 @@
  */
 
 static DEFINE_SPINLOCK(eeh_eventlist_lock);
-static struct semaphore eeh_eventlist_sem;
+static DECLARE_COMPLETION(eeh_eventlist_event);
 static LIST_HEAD(eeh_eventlist);
 
 /**
@@ -55,7 +55,7 @@ static int eeh_event_handler(void * dummy)
 	struct eeh_pe *pe;
 
 	while (!kthread_should_stop()) {
-		if (down_interruptible(&eeh_eventlist_sem))
+		if (wait_for_completion_interruptible(&eeh_eventlist_event))
 			break;
 
 		/* Fetch EEH event from the queue */
@@ -102,9 +102,6 @@ int eeh_event_init(void)
 	struct task_struct *t;
 	int ret = 0;
 
-	/* Initialize semaphore */
-	sema_init(&eeh_eventlist_sem, 0);
-
 	t = kthread_run(eeh_event_handler, NULL, "eehd");
 	if (IS_ERR(t)) {
 		ret = PTR_ERR(t);
@@ -142,7 +139,7 @@ int eeh_send_failure_event(struct eeh_pe *pe)
 	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
 
 	/* For EEH deamon to knick in */
-	up(&eeh_eventlist_sem);
+	complete(&eeh_eventlist_event);
 
 	return 0;
 }
-- 
2.20.0

