Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49CZcBYU1Iuqgipvw7k+FzjlNKnHww3RBL/1ts15zkdn2/HGZqTBhd09rCuMmwI78P5zi89
ARC-Seal: i=1; a=rsa-sha256; t=1524652489; cv=none;
        d=google.com; s=arc-20160816;
        b=mRhISOG1Fw3zkcQ0Mkj9SbufcRShViQxxInxkkvCB7PEjN5WQVWHuwhJfMNHFr3Anj
         rWlcOudbLaaYm4nN+AMRd3emcqs0H2yNKFU+H69RxfUt+DYC2DurgRE7dI6MeETRoFwF
         0Ch/40DAuSy4erz/LvpgZHuEg8LT4Jyq9zCXSyCZ6tGSx6Auv2fr0eq6YJJq96pLPJni
         JCKLOlKeSfDH7msjoqdi0xEHjHYmBva9HiZYF3ogu4/LdN1BAX1nMnBJp1i2hhYGD85A
         lKurm/GWDzd7ZGj+BAyBspuM2gU6nMRzwqnLQL7MkLkA+Q0K21HEsNWNedCMuQarkSfs
         iCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uHkUBf8FUuT2NF7KfrJTnttQ6iTmUqWVIIAs0nyBGUc=;
        b=Z0ueZ6nywz0M21ycQbXzT3vY0Cn0ff4WCV+y0E6w8tK7UgrVutDAOCkjM+7SbQ8iF4
         77eOzf1ueqTlNYzYstWWLS5HCuu8thHuEq93B58VV/1qNkGY/PIUaO+WqznJJQHAQS/b
         ubpIe4a7aJwnokq2ULtSu1MIKirqE9DXwj/bZ+Bxx7nhHZyTl1r40jZvbMG6kIQ1jEXb
         cctGvkpb++k5MYF3EgYVVwJ+wnyqlp0bp+s60FOD+tIU6c2YehY6LDK7/BUv/IHPENBT
         NAMls0VbBX+LoJe3ZT7L3Aa2gGo6QynELW5RX+NGgzt7eCKKUCVeoxAOpc3ORl8TYrev
         cEVw==
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
Subject: [PATCH 4.16 05/26] x86/acpi: Prevent X2APIC id 0xffffffff from being accounted
Date: Wed, 25 Apr 2018 12:33:14 +0200
Message-Id: <20180425103315.066212043@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714008873364541?=
X-GMAIL-MSGID: =?utf-8?q?1598714008873364541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
