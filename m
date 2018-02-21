Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224rzbMjkHZVT9hRH/LwaknzJlMvz5+iAIVW+LFztrmfcMO/PdJ2E8h/J+K/Rgf/vRhPtRak
ARC-Seal: i=1; a=rsa-sha256; t=1519217878; cv=none;
        d=google.com; s=arc-20160816;
        b=FaoxsUY2yG/5e/jscQtn5ABl3jp+lhoIGQX1OfuiE837J+bOMDpHjbC2x3ocdniMzB
         KK3lW6tVhOni1D4M9/uv8lpwk8nTUL05ePXwpBgqEGAhZjCiF7x13pviAXrRqT3JWMkF
         452U8+q+WNXdTok6j2SEWXC+T2W5SuYvhniB80D0BIv12HC8k/bJPaT/LwIj/sM1Ryuu
         sI1iJj3FDnqSxj/ffyaZzqFS97gvgLTk9fT/qHhZLijpREKb53d1ieWNd80Yj37qDxCm
         +flICC75MKR5BzbyCe1hTGfnlotGAzUI/Xn2xC04JmepUtCWnGSrsCPBNomEElEt9QRU
         XcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=72VSGO2dFgtSUsFYyqF9kGtz7Mv+9pYSTaxnOEKFuZI=;
        b=fLOEcDNfVgilrRwVvoo8YXX6tPIhiy6p+Qx4TlMgBhtkn0IlmqIZn8cl7KT+2ec9LW
         XzzRf9nXhpjTdThxoIwLT6ed36x3cSQjTwCILZTSwaFmaJvPXacWZlvJBsbqvknPSA2+
         EzbCcA7FMymn/6D0QfII6S1Fge2X4L4RBZyhuKBjTljatAEVwuGDnzhXiVHK7PTSsZYC
         tcv7gq6TL5TAaWRHx0aRZ+U4iLLiLsoa70Zah71E7F7RbuY/VIpa9nNeNKCJvV4XXBqW
         ClKP+wNgclNkgwsJ/fGa94vGQfBhZOoP2Z8YLuoXdKsjejOt9XnVdrX95dNSqvrYxPXc
         +6Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.14 010/167] kselftest: fix OOM in memory compaction test
Date: Wed, 21 Feb 2018 13:47:01 +0100
Message-Id: <20180221124525.170302793@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015263366853351?=
X-GMAIL-MSGID: =?utf-8?q?1593015405674702468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -137,6 +137,8 @@ int check_compaction(unsigned long mem_f
 	printf("No of huge pages allocated = %d\n",
 	       (atoi(nr_hugepages)));
 
+	lseek(fd, 0, SEEK_SET);
+
 	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
 	    != strlen(initial_nr_hugepages)) {
 		perror("Failed to write value to /proc/sys/vm/nr_hugepages\n");
