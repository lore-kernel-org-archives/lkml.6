Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48JfTQksEeLFxrokih4WZlWw60L/NDHkmI+gwVvWwLJaZBYmQUB4Rce2uKIpLisGMBOFFlS
ARC-Seal: i=1; a=rsa-sha256; t=1524652671; cv=none;
        d=google.com; s=arc-20160816;
        b=CNQaXI/OCz1XRixE21x4bJDr+DD8ULnsfujGSVLKOSYTVBTUPZW/88H2si4J4DRdMH
         g+l7pcT8bHR+iYvUH92KOdutxrcVWHEvYfb7dvMnaKlAnOv4t5cyb23Aa6brxDaqzspH
         pl3NqOvYLkzJiFvn0B8Z1BPusgYCHAuGWHESKHBYNAOcqkPTfWqbTBsL2GUQVVoA3LpM
         ssf5PkGg6v3j3tJl7ghmYclOnEihGE1iuN72Up5NF1xn1VCstAQA1xwTEQTkSMsfWagi
         cfigwQjDD4V9Rp3J1jb2P+m8tnTi/GJ+GGj//nlhVN+8N8220QFwAvTk+dOp8VCr8xqS
         9jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ul6KLmrf3faB/fF9WL7MJnBPvOJ3qBh16y05s/vJy0Q=;
        b=GyPqxsd1rDG7+YEYEx/qTvBNRR6H9BYSK4Gq1fOS30ZiIQ3gVjetU5sFi/91+3CQ7w
         okRU9TVlKYBeF3E7h3YtGinsAOESs9fRyu4PMUm4lxu+DCUMBwYfZSn7AiVhlzGwv3R3
         J/wM5aj3X3stK+l2uCjfOvpo29/AN3bB3gkGExIz32jPPpEY954EAMPuk2mZ0Lr0Rq7R
         cCvjeMnq597xLl3YNd8w6V7odGQI2RjE1b7rtAmsQ5TRPiBe6aatsI7t9PrGUHHgXJDC
         0hmJODB2+aZcuJJFNQFQcVvi5ergQb4sJ3tlpyme57OQ2iP99afSyWdLWJRxh0WrZUvX
         Mh4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	len.brown@intel.com,
	rjw@rjwysocki.net,
	hpa@zytor.com
Subject: [PATCH 4.14 003/183] x86/acpi: Prevent X2APIC id 0xffffffff from being accounted
Date: Wed, 25 Apr 2018 12:33:43 +0200
Message-Id: <20180425103242.737319561@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714008873364541?=
X-GMAIL-MSGID: =?utf-8?q?1598714200133446857?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

commit 10daf10ab154e31237a8c07242be3063fb6a9bf4 upstream.

RongQing reported that there are some X2APIC id 0xffffffff in his machine's
ACPI MADT table, which makes the number of possible CPU inaccurate.

The reason is that the ACPI X2APIC parser has no sanity check for APIC ID
0xffffffff, which is an invalid id in all APIC types. See "Intel® 64
Architecture x2APIC Specification", Chapter 2.4.1.

Add a sanity check to acpi_parse_x2apic() which ignores the invalid id.

Reported-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180412014052.25186-1-douly.fnst@cn.fujitsu.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/acpi/boot.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -215,6 +215,10 @@ acpi_parse_x2apic(struct acpi_subtable_h
 	apic_id = processor->local_apic_id;
 	enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
 
+	/* Ignore invalid ID */
+	if (apic_id == 0xffffffff)
+		return 0;
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
