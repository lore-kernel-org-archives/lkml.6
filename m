Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq+dMvkugniLE0g4stMVVkZ6Pkn9HXKg4or5BPSW2fEx35NI9TmNaeXEP1vMKbkO66HHD47
ARC-Seal: i=1; a=rsa-sha256; t=1526280868; cv=none;
        d=google.com; s=arc-20160816;
        b=W2g2Z7ZiyXB5NmjWcenCJfmSv0kGD/R1e8sNliNdEAiJIEGQR2WXZzJiUwC9NsaLAH
         mvkSoPj6CXsG4xjIYUStHvu3GokXDCAPLWKk9Mlyzp6isZimvhjN8S6V3crK3YyF3SCI
         zE7IOZLPiIfbn3toU1iu9PuyisOfMqPT6XREMbs+L7B2GshHG9sNrO0H2LA6LjaLogKs
         HgXqsIiArQ9LPbKMjL+Bz/62XTBUob4q6sYkEzKQFm9UomXbig7BxZpErek/N6d30o11
         rcXOyi8e+EkqukexvP5G6ZvE7tYnk/DoP7z2bQe1IdhD14w8GT97ysFuNAxdi9hyMXRz
         EhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=r7xnYlr0S0oH4En6OF/CAFnl5mbdrjuyct09vplxgYA=;
        b=ak0dFH8EUGlrj4QLAXtiaFAgzunMH876nIUg44XRn+omAZCA8HlDz8VmS2unEF8aQU
         emEGDjQtzmuJdH+Hla6clxtJGBywUQCuGjjCGiNwGlCqKpRAUEtTYoY7JXeeQdJcx9qc
         kg3MFnrQGoSwAeeJVgk8dLDbzpPUSZucP3+GF4TbTnhej0VnO8uXTtvJPERDxdcdi4ec
         TjFE7hvpxlxqPfswCc+7MjkuppCfoqJU7OBP3gtnSALW1x3IMnBw+rBJ0pr1q2yjUDfO
         qI6OQifolKvj/Pwo0caN8wQKAl/yRvhY5nnRAqg/YRXV6GSRA2pwts7tn1AF27fMPYR/
         L5dg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sanE0TrT;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sanE0TrT;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4.9 30/36] thermal: exynos: Propagate error value from tmu_read()
Date: Mon, 14 May 2018 08:49:04 +0200
Message-Id: <20180514064806.574719583@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421488026333677?=
X-GMAIL-MSGID: =?utf-8?q?1600421488026333677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit c8da6cdef57b459ac0fd5d9d348f8460a575ae90 upstream.

tmu_read() in case of Exynos4210 might return error for out of bound
values. Current code ignores such value, what leads to reporting critical
temperature value. Add proper error code propagation to exynos_get_temp()
function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: stable@vger.kernel.org # v4.6+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/samsung/exynos_tmu.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -892,6 +892,7 @@ static void exynos7_tmu_control(struct p
 static int exynos_get_temp(void *p, int *temp)
 {
 	struct exynos_tmu_data *data = p;
+	int value, ret = 0;
 
 	if (!data || !data->tmu_read || !data->enabled)
 		return -EINVAL;
@@ -899,12 +900,16 @@ static int exynos_get_temp(void *p, int
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 
-	*temp = code_to_temp(data, data->tmu_read(data)) * MCELSIUS;
+	value = data->tmu_read(data);
+	if (value < 0)
+		ret = value;
+	else
+		*temp = code_to_temp(data, value) * MCELSIUS;
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
-	return 0;
+	return ret;
 }
 
 #ifdef CONFIG_THERMAL_EMULATION
