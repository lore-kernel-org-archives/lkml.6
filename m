Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqE7d1TiFrQ59rF1U4xW6IIG26bF1fVR4TOrL/E1idBAxQibLpD2kUKPHAuDwrk2tXHIJ1C
ARC-Seal: i=1; a=rsa-sha256; t=1525116525; cv=none;
        d=google.com; s=arc-20160816;
        b=Hw5FHNCWWWuh3A4ow15oJlJyiJ7gTr8CL7uykTEmD4weOPwAKKzzZS8cTyen/MizQD
         y0Ms6PCoCX+jE9KX4s6D/8EftLXb8dUdTWQvO610iM2NbIv0wRi8KDW2eFc44805endj
         cw2TYCMZAYXKQ41IQ0eTPP+Oj3a0TJ/4fpIIp2dTQjigrcSP911pt0/S3Bu4v4Cdu85I
         CQ+E47UB1j+R0Z9Oq+xtS+6pLPQlODyv/4PD5jXTE3M+c74iJYzdElZGDUgdCL3vmZ3W
         OOsYyiv/7rzKiGP4/5droNbJPIjtgvNN1NoPeW4HJMt7XWbWZjLnsTY8CnKv2uGnYSBa
         6lkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=d2sktCTXonHWNgyGWNhINFCe3Ed9LjzOOp1phQs9pJs=;
        b=MHmK43yoMHtUQVbZiwpbYld+zHxYmXcqPCSJfT0pUZKz5+b3EXNw5SL7Da3UD/Z2yS
         gLX0JNiyi8BmkYjO4u+LRW5j2ULo0lDfTDUdZVzJN1gfz5+zhw9ADJZNaik+1IPiwjao
         q5jiDzC6D/1q3jixQtbKF8VuwUoz99273oQtvhLCsPdlnV5ZCT/cYLUClHmhOwnFi1jo
         CgZa8WaxwbPyOzNecyxAQiujkSU9yOWnEz4aSf+K5Db07QjPN2y2ptTEflLR68gKTUYO
         sU7Szl7f1MRnTF6L24VU1FB6NPXxW504zCcOw/aRGWNWT7JRHTVRGjM64EZtfiX1Nkl2
         G+vQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7589F22DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 4.16 094/113] module: Fix display of wrong module .text address
Date: Mon, 30 Apr 2018 12:25:05 -0700
Message-Id: <20180430184019.174472473@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200586404687010?=
X-GMAIL-MSGID: =?utf-8?q?1599200586404687010?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

commit be71eda5383faa663efdba9ef54a6b8255e3c7f0 upstream.

Reading file /proc/modules shows the correct address:
[root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
qeth_l2 94208 1 - Live 0x000003ff80401000

and reading file /sys/module/qeth_l2/sections/.text
[root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
0x0000000018ea8363
displays a random address.

This breaks the perf tool which uses this address on s390
to calculate start of .text section in memory.

Fix this by printing the correct (unhashed) address.

Thanks to Jessica Yu for helping on this.

Fixes: ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
Cc: <stable@vger.kernel.org> # v4.15+
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/module.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1472,7 +1472,8 @@ static ssize_t module_sect_show(struct m
 {
 	struct module_sect_attr *sattr =
 		container_of(mattr, struct module_sect_attr, mattr);
-	return sprintf(buf, "0x%pK\n", (void *)sattr->address);
+	return sprintf(buf, "0x%px\n", kptr_restrict < 2 ?
+		       (void *)sattr->address : NULL);
 }
 
 static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
