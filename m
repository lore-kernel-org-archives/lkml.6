Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuwQTcRypogvf1q8CIif3qEv9ys27p9/9vB7vW60S1GOUakV/NwM+wZAFsekyJ6d9BRIG1g
ARC-Seal: i=1; a=rsa-sha256; t=1520955211; cv=none;
        d=google.com; s=arc-20160816;
        b=ABtrFUv2Kx52WdQ4Fhj9Nmlw0owYdfaRlFbq/iYQ1+ZHPkAdWduhxHvQkS5SW8FtwZ
         qHNf+uM1MqXO+JerkDZWugmnb3lJgWCucsIqltIJf805i+aYW5CYghOuiiRHe377Hc4g
         iSoO2Yi5a5onTnGQxDS+Y1QXpuLO+GwBhTA2enfwYH+k6Toxb/uTbL9N3QKHFw+pdtEn
         j+MGSyblZwum3M5di6N2KJloDFXl89vD75Cp/fvYjmqU0UIo2pTd10dFUE1ZZwlMIsAd
         Z+g6SuDiKDhhdJf/rzjty+lzvOhe+Mo5/eIm/IGbbcfpzTn1ENnRfwNzp3Ba6eMhRZbP
         Fbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R/db7WB+yL4bHFmGzvpFqZ/zGUxl8EDeb2QJHgX8IYw=;
        b=PC/G1FrRXAAC7w6OWnOLZ3frHdxd6R0moprugbJNyy8H1spRtQ8s41U4sX0qeL9pM5
         LGFVvgHQgQFXB2w9zGASp8BdiOFZDRWDkfJt0vtC+lx5ct+JLFlNmSM3itOtXZt4myMQ
         VoftV9b/YGU6fSnkd4Byxn1bMMgdF6QB2YcAAwn91y2LuE1fsxxn8+19kgz1pjyaLIEk
         gNVkcsKMmpaT9FRDBDH/ekje16F5H1bvMy0cuDYixcya0vU4NueAqxXd5kioS1KeNHhy
         J2t+aP7buR+XeLczB49WARqvAtwOiOhF+oQ8JHSfeY7NAyUf5lKDJ1/rp0FcduyYKmC0
         CvKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4.15 101/146] objtool: Fix another switch table detection issue
Date: Tue, 13 Mar 2018 16:24:28 +0100
Message-Id: <20180313152328.313274950@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837131189847438?=
X-GMAIL-MSGID: =?utf-8?q?1594837131189847438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 1402fd8ed7e5bda1b3e7613b70780b0db392d1e6 upstream.

Continue the switch table detection whack-a-mole.  Add a check to
distinguish KASAN data reads from switch data reads.  The switch jump
tables in .rodata have relocations associated with them.

This fixes the following warning:

  crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool: x509_note_pkey_algo()+0xa4: sibling call from callable instruction with modified stack frame

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d7c8853022ad47d158cb81e953a40469fc08a95e.1519784382.git.jpoimboe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -924,7 +924,11 @@ static struct rela *find_switch_table(st
 		if (find_symbol_containing(file->rodata, text_rela->addend))
 			continue;
 
-		return find_rela_by_dest(file->rodata, text_rela->addend);
+		rodata_rela = find_rela_by_dest(file->rodata, text_rela->addend);
+		if (!rodata_rela)
+			continue;
+
+		return rodata_rela;
 	}
 
 	return NULL;
