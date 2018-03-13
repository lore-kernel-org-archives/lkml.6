Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsKIqtv0pExBQz7q4OB7oGx9mbRX4Tegv3rX4NQavNW38xCwurxuYUlXQsgYllzwRrJOZ+7
ARC-Seal: i=1; a=rsa-sha256; t=1520955063; cv=none;
        d=google.com; s=arc-20160816;
        b=r0d3vPNZUn8Eo8/qi28BcXtvPjQPa2nFJwAsehgiYLc8JhYyMT+B9qgyXF7SVw/BfY
         o2dx2TAYf3NAvNakMFmMW2RBfkt4YaLbNZXO0l4j+WGl4kGjo7FatgvVKRbi6H2r4Q1a
         6D/PrvZdRqdeoe8QkrhkVQ2Y0ddACw04W3ndngCc/bWNSsFG9QL00mlVRRx35slWdfbn
         me0Cnr/s4Yaxpz2LTu1Y+ah8nJNEdWOG0eZyKdvCUzglLmE7WwGhv0b/OTqrfLSSnfek
         nae6M9YRjRCpHnkYhWPzcd0302C7LsbrRzLkRUiLcrQx7ONbmUA3xhpphvahonW2U/Xk
         WXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xk722ifFwffHNojg4iW2tdaZbJ7n3u0icedOW2OWNvI=;
        b=on//TYYeJK2ARvGZgRCFQNUdTvrHoSgI+oUefSGDriwQbbbVc60PEF9kG+BubwovVX
         RjJvj9HywrW0q8ircXTQBYakTWoENwLKEFHSuf16oK2EDevCbBiicI01OzqOrUdlaqAN
         MH3Geml3bKssA+oFU8rsZR+VOcMurq9Wn2PVH4+Py2AChzK2tu+m+13snT63Q13GgN51
         lWkVf3rG3Qt326hknpjRZn/r/o+XAvzfgkbh3nQCMYgdC/lSrpSJ6DHUpd0lFOMGLfJL
         arOk6WjuDjxyF6Vx9rV88FUO9hIkHPyR/HUW4LKDbejtIh7ZvVrhCldRfIdG+frlAzWm
         4rhg==
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
Subject: [PATCH 4.15 042/146] MIPS: OCTEON: irq: Check for null return on kzalloc allocation
Date: Tue, 13 Mar 2018 16:23:29 +0100
Message-Id: <20180313152323.843219417@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836976270829589?=
X-GMAIL-MSGID: =?utf-8?q?1594836976270829589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
