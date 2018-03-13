Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvAWjdvSJWfWQOCBu2jAHWTHrOh9d7gUvG+aglbDfu+9RI+uZXrhLf1tOOrw30tCJ6G8oCN
ARC-Seal: i=1; a=rsa-sha256; t=1520955527; cv=none;
        d=google.com; s=arc-20160816;
        b=File/yD0YiEG66S5zzZfuBI/I5f3mppY4AWMISeCrOe4ldXN0VmtgkXBBX2KNsIJGl
         ZsdqGpEL9AIQRqH7yAjFjNgZZCj0dPzjpmLb2Nr25UmftrPDUjzN/cvb1uWdHY9f0Foj
         k+iru8KM83QJEfKWASfoEHQ6XuXA3NtM4Spi6uLtVFNzIGp5sIU0uM2t7ivfNF11rlfD
         kM2u5AH5lbU9lcriNGb8NvSdv8coehUZRaQydWlYMXl81eErQxnc3Fwc48IENldwISfS
         LbyvFOmEmwi+J3jMA+l77i/fPkqkHuzJnCpkmLPl0UV5NIEU9gWyc2+hucM6C6U9vhU+
         wMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q+DCxLv6QLmJZmySeMRNdgKAFN6mKEdzHW6ePLqAjXw=;
        b=P0AmCulJmJZkYnHlXlJC1JJkwOXi2AhBEDWBtmrJwvStK5nGqLgX2rr18c8QFogKy/
         8FjQTNXlKv/k7k6kixXg8mXoxTZhk92Mg6Af8FhOG26BZIXisfwmcwK0kz7pO016uxiI
         33+y2xEHqeK7jXEnZGFELh3ymsY/i4/dCQGJoqhSjlb5/MXzWI03nuZ8g9+Nn3nk3qfT
         CcXlbozeh00MVC55Wix0JhdAX7rcWNvh7FIYT2PrdwYors479r71YOBiwotOZNt8Ype0
         MHySZKghYfykJEEWqagixIxCD3q0n94LkyzU68gMnvv6d+E/S1vCVtmwKvQGGaS4C3Ls
         82WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	David Daney <david.daney@cavium.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Steven J. Hill" <Steven.Hill@cavium.com>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 080/140] MIPS: OCTEON: irq: Check for null return on kzalloc allocation
Date: Tue, 13 Mar 2018 16:24:43 +0100
Message-Id: <20180313152503.512478971@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836976270829589?=
X-GMAIL-MSGID: =?utf-8?q?1594837462935783800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 902f4d067a50ccf645a58dd5fb1d113b6e0f9b5b upstream.

The allocation of host_data is not null checked, leading to a null
pointer dereference if the allocation fails. Fix this by adding a null
check and return with -ENOMEM.

Fixes: 64b139f97c01 ("MIPS: OCTEON: irq: add CIB and other fixes")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: David Daney <david.daney@cavium.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "Steven J. Hill" <Steven.Hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.0+
Patchwork: https://patchwork.linux-mips.org/patch/18658/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/cavium-octeon/octeon-irq.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2277,6 +2277,8 @@ static int __init octeon_irq_init_cib(st
 	}
 
 	host_data = kzalloc(sizeof(*host_data), GFP_KERNEL);
+	if (!host_data)
+		return -ENOMEM;
 	raw_spin_lock_init(&host_data->lock);
 
 	addr = of_get_address(ciu_node, 0, NULL, NULL);
