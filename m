Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+9Hb6rvAUB21+NvP6SAVple7v6MgnYVajBt1lgESzHPf6n0Zt0rCpTaHmS/cPz1rzsmRJH
ARC-Seal: i=1; a=rsa-sha256; t=1524405824; cv=none;
        d=google.com; s=arc-20160816;
        b=lxUvq20vW4jkSiyYaxqTb0JE08mJZs3Vwu4whRiEs+Dly663rQlVG3/cERmzpt3szy
         2D1qA21Apqg7D1qTJ0bABEJsBSEHH35J1XK9xg4EUHXZOkCgXvVDCgeLluAXRQNYawrW
         hQwPh8KAaGQjhOvsS83iHOUQTWDUwap1hazEkIzxizvvor0jfD5k3ra8Ok+lZvu9ieVe
         K6g8LNBjvPAajcagPTkR5249CfsgjPfFVUkqZVncUqojuYkxqy2Zc5zSS622Zg7r41ro
         lYfYZU/gv6csD43Lu32emfbY+f75dHTPdSVsof3hRN89SeDv7aqqM/1mUog68vMk0HQ1
         WenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7Ejw4516tt/1XWe9tGEjQqqnN2pwefUwZA9nzuZcwJM=;
        b=XTT8ZttSMRlCZ47wqWB9GHoh8otHpKhkAUoFZmnosufDEZ7Rmt0kQx24n11vYmoOAS
         ZyjW/zvImxB3V4eFHY/GA3a/JJuwoPHJf1B/18mS653RQMM7Q4JJLptglB2kwrON+j2a
         nOYTqBsdy9RSh2CpZdJLIT52yWCAb1YwzmaFLLVNaIljwcdp6fvH/OjDcdEelFeV1B8F
         eBPIDm62Nxjega/qtsSMfCuds7Jxia4pGoeKCh35zgyVdVpUXwuWmuOLryf0JXLuNgvY
         nphgZOYsm0X8pI24GD9VFTWWWF9sQ4vCniLKuDnQbg+2MrOPLh8XJCB5dEZzS58Jnn24
         xd2w==
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
Subject: [PATCH 4.14 012/164] resource: fix integer overflow at reallocation
Date: Sun, 22 Apr 2018 15:51:19 +0200
Message-Id: <20180422135135.894415451@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454905898680700?=
X-GMAIL-MSGID: =?utf-8?q?1598455362352412286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -633,7 +633,8 @@ static int __find_resource(struct resour
 			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
 					size, constraint->align);
 			alloc.end = alloc.start + size - 1;
-			if (resource_contains(&avail, &alloc)) {
+			if (alloc.start <= alloc.end &&
+			    resource_contains(&avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
