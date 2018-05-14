Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpQWwGeQekpq/vlHFfb2chIARFdemb9nqM5b79CJP8RiIok7NybWggkECRbX9MsIWzuHGcD
ARC-Seal: i=1; a=rsa-sha256; t=1526281025; cv=none;
        d=google.com; s=arc-20160816;
        b=jtVhhI19QcfJV06eV2ciwkr0Y2UsWG02DBxP/Q4qAZ/JCrt7+wwIMboI+slb7K2YTS
         wvi9yBd6AwDXnL85xji7iinY7YmRPvexsrGBDKPVWfLnnk5YsNOKyGBLK1cmZWgOnxby
         mR1fb7LbxenEg+L/FPpTqRzSobg6MOLsi5XSV6LzIlCxxCv6HB5tcEHJbKy6vL1lpKLC
         KDI38CTlxhqkkcXJNx4NTm4s+rWtGeljpZrlgn8MRA9QK1rLPH+hVorQNtIzRemSR/cH
         dzZ23ofyuZUB4TWUSHL5Ei5URvmh0xEE8pywjRN9KT4UqpZJC8urJBRFiPQXNcEpGZUj
         Q26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xu8QEEEtkezCpyjCvCbBfxhRacBsKF7TOnL1lsvgRtc=;
        b=pHlx2B6mDA1RgoxUBBhof4oBdhWnH4LzVQWKBrMCdBiV1LDwoduk+nQI4/7YDKvsnj
         5DhY5qa/qR+KAHpOKaPRQT1LZ0h8Qo3pernZ+Wf5VUiu3RX+/HY3SjXGk++j1exPWh7t
         IRU0GufdIKuQpWuo0zA2ObucAAbCn/qwcIj5MS545/8UE/prp/uLchLl/5DiXgZh1gQt
         9Mu/6BLF22Hp1jqaOlqV2USCI4hwtObD3WJiv7TLAzkJ0Nux9471VMPP3bpvLQpD+Y8j
         7AUNBn0J1i4aKa8ypzkqY00EecauZXt1ajwDLVuGby2EY8sCG9h8vTAMJycuaE8UKZA7
         poSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JJ+j+pHm;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JJ+j+pHm;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4.14 51/62] thermal: exynos: Propagate error value from tmu_read()
Date: Mon, 14 May 2018 08:49:07 +0200
Message-Id: <20180514064819.318764558@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421488026333677?=
X-GMAIL-MSGID: =?utf-8?q?1600421652653239790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
