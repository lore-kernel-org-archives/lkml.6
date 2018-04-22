Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx489pO8GEQBPJ7WMddvgOi+09MPhHe8xSJU40dt7mUI14wjHkVX7HECJ3O+sLDFynsGMkuXx
ARC-Seal: i=1; a=rsa-sha256; t=1524406804; cv=none;
        d=google.com; s=arc-20160816;
        b=LvfDgYpr7yWm5Uv7GE/GUlEkjMvyIRYDCMn/KEyat2h+FZVMJ2MXZnZpsCw+9vVRDm
         drlOb2V3i63EcdyBhTApEgmOskEsNwz2Yy83e+vCPkakGkL96wzkED/QjiTqi6vpxwil
         2HHy8F7uwWI4MGxfEUTBS+GPFpz6GKqwE9Zz0fnyUOdIdrEEjTthvaAgcrzMI0DV+osK
         +0HpJkE7c+MfgZ/ayvrnMUv4IKibnalUPTX5XH8TyjqR/3UP8ifHbG0MlO7jCFb5f4la
         pLikLHPHZZtK/ZgBfZIs12dlX44UbxmglxaE/L/utJOOfZJ+ZCSMRU9es0n0KQZe2Nng
         GIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xAdmD/wxsN4ZX6vMI83U3G52XoSnOMMPRiRqs1EGxaA=;
        b=FOAqaFVJN2Hau2kfGb7ApZDns3U8+9JuhdatHVr1xjiTgMz0GVH8VY1uejy6UuOAOE
         L1v6yhF54Mkc1449dY3ZA4StAOXVLCxFMDQZ3Qmy7U9oB/i15G4Os502e0in3ukoZbD7
         k+w6gPv7LvG4PwCXQrk4uAbzMrwYQVogDjpBe2hmMXW3NGBYvuS1aC6ySoNCB/i9AjiE
         d1d9X72Q38iRkIpQuMMDlGjxAaVkD9e7JBawjlN8yPkSN9eWCOSWfCbjS1pZYvxw6pBD
         pGuHW66tJyZ8VhaAUxH3RBJ2WDTjKwCeHOcNiU9xXRTclajUJDSpOlzQCBc0D+cI5UB6
         Buaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Michael Henders <hendersm@shaw.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 11/52] resource: fix integer overflow at reallocation
Date: Sun, 22 Apr 2018 15:53:44 +0200
Message-Id: <20180422135315.777927212@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454905898680700?=
X-GMAIL-MSGID: =?utf-8?q?1598456389433004929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 60bb83b81169820c691fbfa33a6a4aef32aa4b0b upstream.

We've got a bug report indicating a kernel panic at booting on an x86-32
system, and it turned out to be the invalid PCI resource assigned after
reallocation.  __find_resource() first aligns the resource start address
and resets the end address with start+size-1 accordingly, then checks
whether it's contained.  Here the end address may overflow the integer,
although resource_contains() still returns true because the function
validates only start and end address.  So this ends up with returning an
invalid resource (start > end).

There was already an attempt to cover such a problem in the commit
47ea91b4052d ("Resource: fix wrong resource window calculation"), but
this case is an overseen one.

This patch adds the validity check of the newly calculated resource for
avoiding the integer overflow problem.

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1086739
Link: http://lkml.kernel.org/r/s5hpo37d5l8.wl-tiwai@suse.de
Fixes: 23c570a67448 ("resource: ability to resize an allocated resource")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Reported-by: Michael Henders <hendersm@shaw.ca>
Tested-by: Michael Henders <hendersm@shaw.ca>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/resource.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -590,7 +590,8 @@ static int __find_resource(struct resour
 			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
 					size, constraint->align);
 			alloc.end = alloc.start + size - 1;
-			if (resource_contains(&avail, &alloc)) {
+			if (alloc.start <= alloc.end &&
+			    resource_contains(&avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
