Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48qeS3qXAAiaBuEVULAO1U9ZFI3YrChZ9x3g0esvexqxAHs/GLnvyudV6riab6JuV9LpdHQ
ARC-Seal: i=1; a=rsa-sha256; t=1524652964; cv=none;
        d=google.com; s=arc-20160816;
        b=T25ACQeAAzhAdS1cioyI078xqwE8e1a2he9NTT6k3M6Ui1FKuvGa5m5ML2vIWd2zZO
         IWCQiNpmMz7X3k5Hv0D5aKBD5XfgMrdBKaulsXwMikn3uEx9ypEgzTwKcng8htj4jqL3
         eSsYe5lcMkIDQj0CJxetGbylU28O8bajw6F/ha2GS9GSMu7qDTjgsBjxLMd0xcS9uNCQ
         L/aN5fH4gmDzzRjBcWFS4d5dW7NeatJGZRsZ3aWqnJVHl59q3M1nP2gOyhYvG2SIhIQG
         1J38pEp1TFbWszsfPWhbrzFNu2j1AYE/txceroxvxkW2ycUAbsvSz5Ad8zw3/c6260Gy
         +Ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9soK/cKGXPcbfOnCnWgGhSMz4WzB4sjDZ75djWAnzAM=;
        b=qQGpfhGACic/d0BgYFfEXgfz1+ZXzqDiKFebK7DN5LAyZacsFdBnU0qLGOlqA0Jj1n
         LcElHg6//jZJuVMrYR3jGdeJSAQAoTm7Wl6S2ouVRLojKMJW1Fp+Nhbav51Wtxx9YFWO
         aXmN9AzWSWbkFaZtyeQn4BQBTfMztZB4rhF3QzdMUGKot7zkyS4vsY01EaNysEnT6GnD
         F4YmTxpyYqQuldUZEfjvXhaZ1vh3v5xhZ8BngVJN6XVEM1GkTKasVeQ/I6F6e9BscEAA
         kCsfrwSmBF1lucnE8d2mZAFdgN51IY6gubaCIi/uBpAwbrVm5uwNZbuxVxBnU4PeUZT/
         Xegw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Matt Redfearn <matt.redfearn@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 134/183] MIPS: generic: Fix machine compatible matching
Date: Wed, 25 Apr 2018 12:35:54 +0200
Message-Id: <20180425103247.804488864@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714506221197015?=
X-GMAIL-MSGID: =?utf-8?q?1598714506221197015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>


[ Upstream commit 9a9ab3078e2744a1a55163cfaec73a5798aae33e ]

We now have a platform (Ranchu) in the "generic" platform which matches
based on the FDT compatible string using mips_machine_is_compatible(),
however that function doesn't stop at a blank struct
of_device_id::compatible as that is an array in the struct, not a
pointer to a string.

Fix the loop completion to check the first byte of the compatible array
rather than the address of the compatible array in the struct.

Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18580/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/machine.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/machine.h
+++ b/arch/mips/include/asm/machine.h
@@ -52,7 +52,7 @@ mips_machine_is_compatible(const struct
 	if (!mach->matches)
 		return NULL;
 
-	for (match = mach->matches; match->compatible; match++) {
+	for (match = mach->matches; match->compatible[0]; match++) {
 		if (fdt_node_check_compatible(fdt, 0, match->compatible) == 0)
 			return match;
 	}
