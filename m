Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsDv16tZ7PLmQdTeoTkm12OlLkTHSepMIGk+zwumj6PaHNe4ukKFr9TKWMDhj3sKI4rgx5N
ARC-Seal: i=1; a=rsa-sha256; t=1520824061; cv=none;
        d=google.com; s=arc-20160816;
        b=qizEcJB9+7lOdjyD0wGh26mV3DAbt2HLpV+f1oldReZGMW9zp3wHNZsUYjBm6TaNb9
         vYlVxMDnNDlN9X7oz/XCqqgddSJX7AJSs+UD9xgouHq8mowQn5hfnmBE6e6oIQs8KDRy
         OGXaP77fwR2J/rd2as32hfGf3h4tGhE8UIZoXrgl55FWsme2d8lwgorPhyuGlOEH3oDY
         0me9uxVrU5OdloSsYrz5CIrYI4aDev15OYbI/DnYCmy2p1241SDZ46kHbT/pn93Yefsj
         KMYiG3y00xD+plhWIxiGkvtmfBXJBa/lNd/nFM9dqdHRhGgCyOjxt7M0ZrZagAxu1wsJ
         67/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=3ZGWIod28ddEGG0Ve5FK1KTN3tX6wgLj8dhqTpSrEjA=;
        b=fgZFglLl3VMHc5ELpez5paGQa2kQ4zUD9PXl1yEjSwDbSvJSBkurm7uFyPdYOYD6+7
         RG5EHULYGZT3ad0hxGNIM2U5pL27RIVXX2Kq+OxbdGvZzqVtuSTeI5f7KY1LT/szo7lR
         Nu5LqUYK7Nfvg3SaKAoocJuQLgzDXIHnaeR8HiOjRb3AXQAmwEllntaD0h5TYwcHTQb/
         p8s2MiOlv7KER+3CnHQbe7dSNWm7964a6gS5ohTsnE1J4n9JlI/FxRvG6WnL/qj8DN4t
         LUmDRZafPfG78caUBohC25hBHamSORRuKnVG8Lm90WsMEznH4th7vijLE5jj59ZH9le4
         zlKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, gregkh@linuxfoundation.org,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 "Andy Lutomirski" <luto@kernel.org>,
 linux-arch@vger.kernel.org, alan@linux.intel.com,
 "Kees Cook" <keescook@chromium.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 kernel-hardening@lists.openwall.com, torvalds@linux-foundation.org
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.163616880@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 086/104] x86/get_user: Use pointer masking to limit
 speculation
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699610617990203?=
X-GMAIL-MSGID: =?utf-8?q?1594699610617990203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit c7f631cb07e7da06ac1d231ca178452339e32a94 upstream.

Quoting Linus:

    I do think that it would be a good idea to very expressly document
    the fact that it's not that the user access itself is unsafe. I do
    agree that things like "get_user()" want to be protected, but not
    because of any direct bugs or problems with get_user() and friends,
    but simply because get_user() is an excellent source of a pointer
    that is obviously controlled from a potentially attacking user
    space. So it's a prime candidate for then finding _subsequent_
    accesses that can then be used to perturb the cache.

Unlike the __get_user() case get_user() includes the address limit check
near the pointer de-reference. With that locality the speculation can be
mitigated with pointer narrowing rather than a barrier, i.e.
array_index_nospec(). Where the narrowing is performed by:

	cmp %limit, %ptr
	sbb %mask, %mask
	and %mask, %ptr

With respect to speculation the value of %ptr is either less than %limit
or NULL.

Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727417469.33451.11804043010080838495.stgit@dwillia2-desk3.amr.corp.intel.com
[bwh: Backported to 3.2:
 - Drop changes to 32-bit implementation of __get_user_8
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/lib/getuser.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -40,6 +40,8 @@ ENTRY(__get_user_1)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 1:	movzb (%_ASM_AX),%edx
 	xor %eax,%eax
 	ret
@@ -53,6 +55,8 @@ ENTRY(__get_user_2)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 2:	movzwl -1(%_ASM_AX),%edx
 	xor %eax,%eax
 	ret
@@ -66,6 +70,8 @@ ENTRY(__get_user_4)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 3:	mov -3(%_ASM_AX),%edx
 	xor %eax,%eax
 	ret
@@ -80,6 +86,8 @@ ENTRY(__get_user_8)
 	GET_THREAD_INFO(%_ASM_DX)
 	cmp TI_addr_limit(%_ASM_DX),%_ASM_AX
 	jae	bad_get_user
+	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
+	and %_ASM_DX, %_ASM_AX
 4:	movq -7(%_ASM_AX),%_ASM_DX
 	xor %eax,%eax
 	ret
