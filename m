Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/wWdQIC8ZDjnZbl5ot8k7vEurr+ytgFKPpH/qBvJIh5ocGg59YI/r2JdbPj1ewg+CeYaGF
ARC-Seal: i=1; a=rsa-sha256; t=1524405416; cv=none;
        d=google.com; s=arc-20160816;
        b=QoQdEv76/T7kM8+4CToB5jkNZmq2Hsx9H0Qot0ycRiv+oFL47h+ehtJdXXVh1lTf/j
         WlETeK9Ve4E9OYrXlbNQJg8F5lnxW4rsgeFxMr1RKcW9dgli1x5FCtEuaogIeMWZz8P9
         njdRVB5Cvcyz1EyNePrgmhT6f5fklPXoE5ji3ioDQbh/EGg1G8pX15TEeQ3cVUnVlGpr
         I3Y14ccl0Ufscsy3nc/MHlsaa4UBbKsbZ0Xxp2uVrPFLijkFJKTUPoQE5XhTo6706oOH
         qAOlCZaXnETrx6aPfIg5GxtgCvweSnR+xeZPH40hGoLWj9eOHZ2ny2wX8Agn9cqbfFi0
         /A9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KCN/QKNYTlT1Bp7DhsiYkanPgVUXZsR4Sh0GTkOyncs=;
        b=a+qzrYwv1KXCDDRJ9QcoZfGja9/HkfdEZ5BqxfaE+Ry4tanjN2v7uxBqpYetnX8MpZ
         StJQEY5mo6ERjCkcD9Qqogw5HK2ukrb/3R5hplpCfBvfBtLRjJI3m3IWDVKTJ08etwdA
         uHjp1FzU6IMaa7UCH4fOXdwCt15qtLL4eoV/qMoc1bKpa3Mg5t4k1jb7n3lJh0B2/S4I
         EhQR0vxu3Jp959tEFPzpWB6zMBRXUcGkTLGE82CFd7qP1VvnVEmOXvxC6um8eQh2Xj9j
         hmKYzKFu1wXqiWgVpk/UOU7SOGAy+9icUO6+mZu6twLekhIfRgUjbwBopt5x472cBXru
         r93Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ram Pai <linuxram@us.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 059/196] powerpc/64s: Fix pkey support in dt_cpu_ftrs, add CPU_FTR_PKEY bit
Date: Sun, 22 Apr 2018 15:51:19 +0200
Message-Id: <20180422135107.270657741@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454933876041002?=
X-GMAIL-MSGID: =?utf-8?q?1598454933876041002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit c130153e453cba0f37ad10fa18a1aa9c9a598a59 upstream.

The pkey code added a CPU_FTR_PKEY bit, but did not add it to the
dt_cpu_ftrs feature set. Although capability is supported by all
processors in the base dt_cpu_ftrs set for 64s, it's a significant
and sufficiently well defined feature to make it optional. So add
it as a quirk for now, which can be versioned out then controlled
by the firmware (once dt_cpu_ftrs gains versioning support).

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Cc: stable@vger.kernel.org # v4.16+
Cc: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/dt_cpu_ftrs.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -658,6 +658,13 @@ static void __init cpufeatures_setup_sta
 		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_300;
 		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_00;
 	}
+
+	/*
+	 * PKEY was not in the initial base or feature node
+	 * specification, but it should become optional in the next
+	 * cpu feature version sequence.
+	 */
+	cur_cpu_spec->cpu_features |= CPU_FTR_PKEY;
 }
 
 static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
