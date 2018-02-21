Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Vg9+UL2q6yqVPQtFgbejjACim1hNW+KJshPxhRt9bbNG/mXQAMC7dSlIiP7kC+vuv70UZ
ARC-Seal: i=1; a=rsa-sha256; t=1519218363; cv=none;
        d=google.com; s=arc-20160816;
        b=KVeRiJO6DinnEOowvJUYhiulaC4ZuIuRL0HvzyJjV9HRUgShe4O0vy0YVBS3oAFx5b
         WCr4bp41BwxHtmWU4OSC+qwBWhUQ8slAnAXW3SfK9QTMHM/wS7rPQS7oylnUkTXCiNc4
         A7TFFpwsAoxUgRrwM9NOO+CMh1PU6Tgng37qi7DtmifB7L7b2qqV5iLvHiq6k/PSXO5X
         /yg+iG4Qeuj7Xgu6l9Bod68QUbQa6EJayj1OKs9/iCQG9KD4WdCDkNDbDEdad3L+Syh8
         bCrMCkBNvMHe5bRZEuY+8buT+NefLZ/WqQO7SufjFB0FYvIGXBM7i4hrCNPrBM7B7mnM
         Kotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BZcG2bVHk8w22ljv5jQa1QvdQXHhfVOo3EVxedO34rk=;
        b=IDHMDZYBC/lnfMubfCbBPMeCfpTCuDheuaWMmLp4zPeA6BhGSkUNdqFMp7GsznG9+q
         ywPkNV94HBqTnG8N38+ycdFW9Nh075y9nRuVUTggg91LZQiaWj/GdnVMF3PakSi5cAwm
         XUYutyhc0J7WaIf4M68AmHWBAh7TGVH/lde2BkAPf7sMSjOP2yr/bEZq/6CIQ0LeEs2b
         pQJFwAcvSploWn+tUoxPY3wGS7i6B2W3wVVffqzQ0xoosRdWygYkXjvcxVx2siqLsckT
         qXTBL2VZP33iTA7pcO/9BGUVHbr9nPK2iYUWyrVlu+j7ocUIOeyyzHBxaBU1QbohJm4U
         WKjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alvin Wang <wangat@tw.ibm.com>,
	Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.15 013/163] cpufreq: powernv: Dont assume distinct pstate values for nominal and pmin
Date: Wed, 21 Feb 2018 13:47:22 +0100
Message-Id: <20180221124530.749165769@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015268788550839?=
X-GMAIL-MSGID: =?utf-8?q?1593015914075350403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

commit 3fa4680b860bf48b437d6a2c039789c4abe202ae upstream.

Some OpenPOWER boxes can have same pstate values for nominal and
pmin pstates. In these boxes the current code will not initialize
'powernv_pstate_info.min' variable and result in erroneous CPU
frequency reporting. This patch fixes this problem.

Fixes: 09ca4c9b5958 (cpufreq: powernv: Replacing pstate_id with frequency table index)
Reported-by: Alvin Wang <wangat@tw.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 4.8+ <stable@vger.kernel.org> # 4.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/powernv-cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -288,9 +288,9 @@ next:
 
 		if (id == pstate_max)
 			powernv_pstate_info.max = i;
-		else if (id == pstate_nominal)
+		if (id == pstate_nominal)
 			powernv_pstate_info.nominal = i;
-		else if (id == pstate_min)
+		if (id == pstate_min)
 			powernv_pstate_info.min = i;
 
 		if (powernv_pstate_info.wof_enabled && id == pstate_turbo) {
