Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49CRzpVK0W2CEaSfPvY1ckLN0Ygt4FJtw0f4TFy9mpvhL68ZYRBuiGwlwmaw9wC1p0PWWPh
ARC-Seal: i=1; a=rsa-sha256; t=1523981127; cv=none;
        d=google.com; s=arc-20160816;
        b=uOaad2zYchuUm5ynqNF6b/jl/Cti6i98DRg5/9Gul7qvUf4XazZA/g4g9LskHKK0kV
         jnzsjEWocDE8jqFc/CIiBOzaBCswCi67xc40affV5VCIKD5tBAqrbrh+RJBLx5v7cwzy
         C2w4uuc9fiTBx1hkXnh6k1F1o2zEClBB+HJ1F0gTON5VFOSYPb9Ges+47wRVDxR1oESr
         viF+vNqLNnoaPnUEy08hk9gSGsrLW/Me0v3mdzNHcXjsosbQ80KP7nOxFWzqVUN7CYM7
         Z7tBP0ElwQOjvImrUES5rnZ1PbU8OvjWR8RpDHbpr86yHDxs5P/Yb0Pm9sStFAFjMZH2
         tTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+gTL72jxeb5zBDcWT3bCqUvPihRtKnThlxPdFuTD3oo=;
        b=ZjCk2IsuXaamWSOWkMsjCv/JN3swvyIbqsfS3oaDv7LrKXNMdo/SGQ20qhm2mGFn1R
         vZ34fjX1bgbxgvzk9jJS/5JNKfSDRFVGS78WtepWZfur0Qam6rPLnhOdxEVE7134/yvQ
         B8TrVhjC5+32LWqkjahCrZ4ouLe1CgbHgcLsMj8aOTNvE8PW5rCqa3T5H1Z8IGR5K9u/
         LxXylUeChZOVh6JUWhq0jUFjLHXTfoD1pYGsM/CAu7PjjsDWXliAk7SEeDSUiuy0/pZ1
         yJgyAQ8ATLabmI/MlYnLclrRTgvLyO/zWaqXApWahEz+UjOE33/71HjuT2vcFXTX4kg+
         ajeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.15 45/53] s390/ipl: ensure loadparm valid flag is set
Date: Tue, 17 Apr 2018 17:59:10 +0200
Message-Id: <20180417155725.283831655@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009848537812841?=
X-GMAIL-MSGID: =?utf-8?q?1598010035078134296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

commit 15deb080a6087b73089139569558965750e69d67 upstream.

When loadparm is set in reipl parm block, the kernel should also set
DIAG308_FLAGS_LP_VALID flag.

This fixes loadparm ignoring during z/VM fcp -> ccw reipl and kvm direct
boot -> ccw reipl.

Cc: <stable@vger.kernel.org>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/ipl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -779,6 +779,7 @@ static ssize_t reipl_generic_loadparm_st
 	/* copy and convert to ebcdic */
 	memcpy(ipb->hdr.loadparm, buf, lp_len);
 	ASCEBC(ipb->hdr.loadparm, LOADPARM_LEN);
+	ipb->hdr.flags |= DIAG308_FLAGS_LP_VALID;
 	return len;
 }
 
