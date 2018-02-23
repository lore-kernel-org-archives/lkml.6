Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuSWDH8GjpA4sJUbb/cIKAgJ+ZLu+urudM3i5XkcA/vCvNyzXqvd3HdWGWz57wmUBI5bYFG
ARC-Seal: i=1; a=rsa-sha256; t=1519411094; cv=none;
        d=google.com; s=arc-20160816;
        b=acjdjGJKMuacfAfapjgwtuC/D3E+y7ziTIAgv/DkfzoTRzKUpYP+u1kKBlSQcbvCDW
         5XVGo7ZE42a7zlwXae0huA4jlQFBmhhkCzZioBl/K5znO3NDM8iiron8yK//A5wOFMY0
         KGKxIeXnbuwNCTecW7xyHkJkgbVipkEpN0BGEKSi7PIfrqVA4/7BnNAJfmuhHXk2pUnH
         h2MihbhqKGSGuXU2bHQ5WEpa8pL6+QWP/xJIixthWhNoZ0wu8bTKKXmYv82OdmrT57gB
         JgB4uTX3N+MsXLfNWgfuzeMG8ZvVHZkGkUp+SVQpWNyR4U644oyTMzfWaHxneqI3yfix
         QvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=a12DaF6UnAUFC25id0VDihPkFUZazdfPGkOAimKj8F0=;
        b=rjI0Eu+uyo/DgbsScwyS30YycLxBU0hH717GasPnIf+861ADX+3ZPfetbmpU1fTdet
         bBkKPTZUcsDAU/wdaUVquGSeOdYSAoqdqo3cE8bZx+z2Ay+SFZ6pzi3tA0BkJUCG+rXg
         iYJWcTKLv4g4VbHKKY5YsYN5ZZSkTzj8cCad+gtC9JK8pcl6Q5UIKiO00p0T9urOWVx9
         UyPimFtvrEbOH73jaNodFKxrXgMQ55yP04L7Y2j0ujCmIBnRyORnziI34krigYXj7IjK
         1RNCwVcZXjL0nOBBxqeATK9HfP9IcCRfZFDV4c3yjwGkhCp/OJ3OGrwSGLLgqUX/GXTa
         xNhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Buesch <m@bues.ch>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 081/193] ssb: mark ssb_bus_register as __maybe_unused
Date: Fri, 23 Feb 2018 19:25:14 +0100
Message-Id: <20180223170338.726633607@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218008257181873?=
X-GMAIL-MSGID: =?utf-8?q?1593218008257181873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b7e2d195cc523bd92ed7a64aac089421dbab2a2d upstream.

The SoC variant of the ssb code is now optional like the other
ones, which means we can build the framwork without any
front-end, but that results in a warning:

drivers/ssb/main.c:616:12: warning: 'ssb_bus_register' defined but not used [-Wunused-function]

This annotates the ssb_bus_register function as __maybe_unused to
shut up the warning. A configuration like this will not work on
any hardware of course, but we still want this to silently build
without warnings if the configuration is allowed in the first
place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 845da6e58e19 ("ssb: add Kconfig entry for compiling SoC related code")
Acked-by: Michael Buesch <m@bues.ch>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ssb/main.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -613,9 +613,10 @@ out:
 	return err;
 }
 
-static int ssb_bus_register(struct ssb_bus *bus,
-			    ssb_invariants_func_t get_invariants,
-			    unsigned long baseaddr)
+static int __maybe_unused
+ssb_bus_register(struct ssb_bus *bus,
+		 ssb_invariants_func_t get_invariants,
+		 unsigned long baseaddr)
 {
 	int err;
 
