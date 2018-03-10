Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELulvq5qG6dp0XoweofDgEOK0oZ118UJBvq52AYllciBWbXzZ5M6gXKYf2q2NJHD3mpZX2hH
ARC-Seal: i=1; a=rsa-sha256; t=1520641277; cv=none;
        d=google.com; s=arc-20160816;
        b=QQA3m1D7sVcKtlgNBMdhjYg7s31qwh82Tx9p2ufj7NIPDccI3ve5Wy8jczscdyIWQG
         1+MgNrAPme7G2U5ufzuHnmOVUCG+Ko0FE/C0CeKGO68xXisgVfrGxRs0PfUXXGCyR1Zc
         Nvw1QfnytkmsTIXwMcg8Cyhg8z/VwLbyE3Y7o5urgmcROycwQJcBWEieR5sn//1rOWcb
         P6W0qguqtVz4MUlJnZxsqryN01b9e94RkUeVjX+oGl0EZ3yflYXxArNwawkX9DRtGigJ
         SFUzcFM0yxlHUrqCosZqHOtMkRyI8tpaxIP3HLcQk7RLYr0Qr5/5/PkEQUf2xDOdWLAe
         aHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1A/lOhMvey1fJ5qrShpLfcRb0I/Zwtd+6yvYDIlrxEE=;
        b=1IDgw/JIJetOKl3t8dgC1Ak0xG6QRiwPmQbVB75H27Z3jaLDTyGCKmz5jdf58msr0B
         3KhhCTiJdIqkyvNPw7LWiP9vuaoUX+4MxgE0qL+vxJnq3bepD3h6eGk4FNc94XjEsKd9
         hIHvTJ8XprFpv0GKadrDSbeJLkgixYEHHshcCqetoXLXeqLWmfTB8VEj6nQ5V3y5v4m/
         QZLWzMwaIOAW1P9RIQl+oKXvWbxj3kAibJ6wj4/S8xQg/xjt9b9H88+DKO3IL/kSqyTu
         7oRu39dW7xDOXv13e1pe3uv5mJF94tpvIjAI7KQKn+m3a7P0pU0pe+YQBDB1S7OZvIgo
         Ynag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will.deacon@arm.com>,
	linux-arch@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 18/65] nospec: Allow index argument to have const-qualified type
Date: Fri,  9 Mar 2018 16:18:18 -0800
Message-Id: <20180310001826.416622744@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507892706683015?=
X-GMAIL-MSGID: =?utf-8?q?1594507948105770078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit b98c6a160a057d5686a8c54c79cc6c8c94a7d0c8 upstream.

The last expression in a statement expression need not be a bare
variable, quoting gcc docs

  The last thing in the compound statement should be an expression
  followed by a semicolon; the value of this subexpression serves as the
  value of the entire construct.

and we already use that in e.g. the min/max macros which end with a
ternary expression.

This way, we can allow index to have const-qualified type, which will in
some cases avoid the need for introducing a local copy of index of
non-const qualified type. That, in turn, can prevent readers not
familiar with the internals of array_index_nospec from wondering about
the seemingly redundant extra variable, and I think that's worthwhile
considering how confusing the whole _nospec business is.

The expression _i&_mask has type unsigned long (since that is the type
of _mask, and the BUILD_BUG_ONs guarantee that _i will get promoted to
that), so in order not to change the type of the whole expression, add
a cast back to typeof(_i).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/151881604837.17395.10812767547837568328.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/nospec.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -72,7 +72,6 @@ static inline unsigned long array_index_
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
 									\
-	_i &= _mask;							\
-	_i;								\
+	(typeof(_i)) (_i & _mask);					\
 })
 #endif /* _LINUX_NOSPEC_H */
