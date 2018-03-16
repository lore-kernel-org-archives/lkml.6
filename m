Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuKZBcmTXhhF18IUh3b05hAV8vD8Zf7qBTbSE8SNiesKru4U29euaNXegzKPUfmJ8x/Fcf2
ARC-Seal: i=1; a=rsa-sha256; t=1521214106; cv=none;
        d=google.com; s=arc-20160816;
        b=gyJgQC5raWcUvYgTbGAYYmCpLw717fj+LCuMucnCaPjqT11H9T08mBkCYAIoZgo6Jv
         1aaxxuv2SmvxLfj0fHUa/JjKvKmusISu9gpd8+JbzKJaSbGCE1Ohy2S2BW8iOXWSsX9F
         qxLJXgmPUphuoZOX71TBTkPAzBr7qYviksftzaqbtBdzRuZaXKNuvMRX+bIev/Z8xvca
         w6C8qv3cM2p4k046W6yJAepvnMoGHEhE/76QU+Xr4Zzy3ByCYWg3OIAzG1CJTvNLOxPI
         ylqa83BnRlDBPkP+aFvsRLSsEtEpyBNhxuNcJ1JvULfXyJSXTSFSW1EkR9ySA5abV6Uf
         43LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BPO/Dx5hrLZ8A6f4TJUpWOWxKMcZIGKgpX49B3xg4Ik=;
        b=fnkfmDOuAgiOHpluVbLXT8ZDJZvXK9PoHFZYKEgsP7kj0dyC3BViivQQ3OTh/ndcMY
         5Zly6etkZYG6kiL6EAZLKZgn5OSbAh7kpzdnXhX5YEX9CkIZHHbPqo9+6W1La8TZS0hF
         HK9Ne/Jslt43XfUbnTcI2REwnLoNoVW8Wl3zs8AxQl5bU2sXGhd/BHclLv/urTPLbG8T
         Pi480PZgpJwBHeAC9TsQfZ1K3fYtoqbVhvksam0Tf2W/Gko20niEajDIb9zR/LSvIbgf
         pz1yAFDiScrlCkb7CT12K0EBx+D/Emm8Hzwfjv1yrpxHS6wqKkSVSHDT7W4QLpg6RjfX
         +GyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.4 15/63] MIPS: OCTEON: irq: Check for null return on kzalloc allocation
Date: Fri, 16 Mar 2018 16:22:47 +0100
Message-Id: <20180316152301.710281577@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108602604550470?=
X-GMAIL-MSGID: =?utf-8?q?1595108602604550470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2246,6 +2246,8 @@ static int __init octeon_irq_init_cib(st
 	}
 
 	host_data = kzalloc(sizeof(*host_data), GFP_KERNEL);
+	if (!host_data)
+		return -ENOMEM;
 	raw_spin_lock_init(&host_data->lock);
 
 	addr = of_get_address(ciu_node, 0, NULL, NULL);
