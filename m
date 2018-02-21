Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224iytzKJIn6+qaVR8MHp3grKZcKdmEVJAH2d+Z1LuTvnHQh0nvgeZOUVKPPA13vcoRJDBcS
ARC-Seal: i=1; a=rsa-sha256; t=1519218265; cv=none;
        d=google.com; s=arc-20160816;
        b=wEY+fYkBdJz5cH2xW9R2g9oYsTuW+C1eEpaqH87ExpfHzccyZBPCTTLaAYuk72ILgG
         8YlJy/FQpBnvdShruR+vuZWDoWWCB5IyLdQ116iudJr0AuRecuPLeVor6ITtozxefHb0
         eTYqQ52IKJvl3YRPYCjIckbwkiWQhG0ouSE7nUyziwS6Lk3uO34PAIxvk9WjlGnB8u7S
         vHP8XGqZdXnr18DnTcfS0/T+VhppYKYRcpY7YkeWXk7P3iGLaL9rWCrDgg99PD8fFP0q
         0apfXvLGP7e/uFkgLkhqX35669YQeZT4DOf4+zujEDPt/uFJA1UoqLDK8DEdUkoV1lU/
         JhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i9oOFGNTZ3P+/x5oqYo/5BH4x4wN9l4Z4EwMRyUcYbU=;
        b=ZN240ijFu2ehHVC0ieJaYQ/EeqLpP1fHtsUp92D134N00X67eovHHpUQl1PqshN94d
         1zYhvqaZnF26wAQMgKmyn+6j0L3CsqZiuYPegrR3Em18TupXksMOr2pL3ud4fyOGRr2r
         PyjDLzKMefLwy8b0tKIm23gWBXiLpovB5yUM5RmOkOJc/ZkJRrlsDDbkMAjZgubQ9iGk
         4+qLcDL5F4LxyQBlq5OYQ9iB1EGFeTQztoPO9szPmJ+FG+PLaqSaOPpS9xMoeP+0i1X/
         Q8b6/u6u+NK2TUe4dbX5bCFRqvKuU38t0ESojyrqAFDxHmHkUf0LJtpCZtM8hK3kCiiM
         +OUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Jan=20H . =20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 110/167] mm: Fix memory size alignment in devm_memremap_pages_release()
Date: Wed, 21 Feb 2018 13:48:41 +0100
Message-Id: <20180221124530.383261933@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015289662337043?=
X-GMAIL-MSGID: =?utf-8?q?1593015811122172460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan H. Schönherr <jschoenh@amazon.de>

commit 10a0cd6e4932b5078215b1ec2c896597eec0eff9 upstream.

The functions devm_memremap_pages() and devm_memremap_pages_release() use
different ways to calculate the section-aligned amount of memory. The
latter function may use an incorrect size if the memory region is small
but straddles a section border.

Use the same code for both.

Cc: <stable@vger.kernel.org>
Fixes: 5f29a77cd957 ("mm: fix mixed zone detection in devm_memremap_pages")
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/memremap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -301,7 +301,8 @@ static void devm_memremap_pages_release(
 
 	/* pages are dead and unused, undo the arch mapping */
 	align_start = res->start & ~(SECTION_SIZE - 1);
-	align_size = ALIGN(resource_size(res), SECTION_SIZE);
+	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
+		- align_start;
 
 	mem_hotplug_begin();
 	arch_remove_memory(align_start, align_size);
