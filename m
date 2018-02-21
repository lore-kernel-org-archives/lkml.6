Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Qo/Lk/LLjQoQh0VnN9vs1gT1w8xO6bB0M7AkW6FUtPUpnEqBY2bHFBx8XhizGUB0IdpjL
ARC-Seal: i=1; a=rsa-sha256; t=1519218671; cv=none;
        d=google.com; s=arc-20160816;
        b=TJiq6U/BmG/AeJliPRB8LiU9RAaLTp/DLafkTTGF33kE/TOrJEvQFEqBMFtqast6Yx
         wxRaLFflvjPPaIpYYNBgNE/6b+YrsOfEbgVIUmrH5Fr70v3kZwEs6OnQKZhVGFEwF3Sd
         vnhT11i6PMhiqzWBHm3kq+mA56WlH0HlrDnKaVhVj6yZQ+cZ6nQWUyP1mVsAVRgAz0lj
         493Sk7FeUTMwAumN939uenbikMvFUBEuCmKm9YQ7OIxHjFktmEU4PANYQoW43ShNM8be
         6eXQTN59FqITvQj8oatyqjsaaNd3OwKN3VIB1vVlpkwPjJfCHWIOyJWRDwVz+JcIlC0T
         H8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vGADRGJ2/2n5iWzGpOyRfmmlQhxmk7dIsxuWtRvJ/vs=;
        b=Qfey0mfTkWwsIcqQgPj4VaihmnLAKR3ominFMYgBdFHEzRWXPhmxvxI4IGOZUxE5hF
         DIX7NCvDbU7lo0TG27LpU7+7mm8zKTAFF8TEuiwpDT2F8Vj8jy9QzYD0fV+DOQIPLAc2
         7JELG5BB55a6TxsmJA7B8lXtZnvOb+hUkWcgUcqsfZnsUBK9zTqYUvZO3ziPWubSKOgR
         4JWFDKZDEvp1UnfAXm2WnKX3wpGZEpTmYSEJZcv3hCKaua7h+fcGJTPtWALVt0Jw9GCD
         HsdIvhez9l7ADqTGNsAOQQOvT3y5xZHnn9e2UEKCouvJjnhP/vGVyY6AAwq/qgvmqabu
         BSmw==
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
Subject: [PATCH 4.15 111/163] mm: Fix memory size alignment in devm_memremap_pages_release()
Date: Wed, 21 Feb 2018 13:49:00 +0100
Message-Id: <20180221124536.316085869@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015289662337043?=
X-GMAIL-MSGID: =?utf-8?q?1593016237769357400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
