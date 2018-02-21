Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519217746-2-5043669254133215159
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519217745; b=VXctELJPU9myrLu9gVtfCatUaqmJ55We9IC/dhJiifRD/mH
    QRdBDZbTM2mZpryJex9FSa/OTYDcl6VJdmyBossJWLP0KL4FlVM3SMK1oX8iJfHZ
    3O7nwcnINtiWUHUo6EH6prWP3YcJlr28Buk4arkvgPchKRE836Dy2m1yexgJv0/A
    xGldSH9yxJ7NKyDnSq4md+vaf6mSPlWgj2g2lEU9KkgVP9JI/NCRhscs1r/8lsNb
    Gkc12gDFCgYqVEoOacQuqlkvYA0TSO4QfnDc1GzkIG2IlmSO6CzpW13Qpd4W0KPa
    Ki2A1uX1vfBKYjk1Ax62wGkcwI5BVASGqIhJAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217745; bh=aD/jjckIipvLqHsICzTXIh/gu7
    jaaAeix+qkTMjINio=; b=wsN3Q9LD0gmCRN5947B77zs3FgPuQ7pBpw9qs3N13Z
    4tbnkDV1PSO1jcNpkiiqZ8gzN06ZMgFxJi6YgIbg0aM/3zrEgldFfo5UFgsdxCCX
    bCsn9frFWuq4F6WlFX5mhYOzUHm2pOUlBLEvS4fRrFnoy5yENNWjcdr2w7aKL4qW
    h6/RHrmpsYRCVHZw8xCKLge/a+/Cz1QlKQ7pH0ZkiA4OEt3ePC60BxIFGhLXwTPl
    y3zjaTrJ3uFefjhvhPvE0b++s1VAljn/YzYw0gkFDLB4tj+MMkoVlyqAmZsdWPH8
    zxwl+Un06jcHnOMEYmNVP5hKCxmucFLk6Hu/C/krwLiQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeBUMzm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:55:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934328AbeBUMzk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:55:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 37/77] kselftest: fix OOM in memory compaction test
Date: Wed, 21 Feb 2018 13:48:46 +0100
Message-Id: <20180221124433.736840791@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 4c1baad223906943b595a887305f2e8124821dad upstream.

Running the compaction_test sometimes results in out-of-memory
failures. When I debugged this, it turned out that the code to
reset the number of hugepages to the initial value is simply
broken since we write into an open sysctl file descriptor
multiple times without seeking back to the start.

Adding the lseek here fixes the problem.

Cc: stable@vger.kernel.org
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://bugs.linaro.org/show_bug.cgi?id=3145
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/vm/compaction_test.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -136,6 +136,8 @@ int check_compaction(unsigned long mem_f
 	printf("No of huge pages allocated = %d\n",
 	       (atoi(nr_hugepages)));
 
+	lseek(fd, 0, SEEK_SET);
+
 	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
 	    != strlen(initial_nr_hugepages)) {
 		perror("Failed to write value to /proc/sys/vm/nr_hugepages\n");
