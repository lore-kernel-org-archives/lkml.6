Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224eMjz2wdQD087JHnEoEsbkFc6uuRAr/yEbj8WP8ltdHfc5DjKRvS4nR10nSsUnTs1w4yzM
ARC-Seal: i=1; a=rsa-sha256; t=1519218396; cv=none;
        d=google.com; s=arc-20160816;
        b=Kc4EVlKp0xFgf6pMu/cCxwhUfbGyubei19rIeO2QMI/AW+abGO8KphTbGFMHM8LM/f
         tLiy1j8aVB4yPxRrpeNlS9CXHTQUoSFOtGMFPHPC6G9i1dAPPrcD5IZnjBYer7S/dmld
         6TrFVt4ten/9VzsfdSrEzm1zAHPWEvaI2O+saVbOW8tNXpiBcjfJYaHGla0hVWw7Utnk
         LGuEgexbEIbYQWGu+5ShVWJG4dNZeJ5/eKrBWImuUNEzhuv67izcAFXo2aDkCgcc677H
         8YH+NcIJxaDg08FokcSYoaZeygzzTgQSQWYLBmbPXRFZB+56QA7zOxbySzt3Q1ol2R73
         tung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+Jv2ZS98Z/x5AdCDBxcOu4fGcaoiClVSxNmLjZgsdO4=;
        b=WumXCIgoeZcMbSyIhcF+k+R4e4J5M88+dp1d7Y5XelPGCiogQJ2t4OOozA1MGgcmbw
         OY5j/dLiZYKYefgCJH0sTn9EsenPbfaJGKpJN/i7kxaPYawv7mjg4rwA17/DZcNrHwsY
         RMvAnRPBEcddfTs7Z1gu/CX/EgR8oJNs2y6uOas4RnBaYOYhazWNOyDww/RMQPLEqFMD
         28mKHbK1loPvIBevxqxoAJ9Mf3/GZNvxTKnDo0eAtGl+oQOswYbKGc7AR2Y1x1rPhbWn
         wVVh/jjz1BjZWZg6MvAQ/oksAVRLIaNl2EeIiJA7OscHBrFsB+iV2d6zIhTq1QMqg1Ab
         1LxA==
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
Subject: [PATCH 4.15 009/163] kselftest: fix OOM in memory compaction test
Date: Wed, 21 Feb 2018 13:47:18 +0100
Message-Id: <20180221124530.494842645@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015263366853351?=
X-GMAIL-MSGID: =?utf-8?q?1593015949145462280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
