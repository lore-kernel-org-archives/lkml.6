Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D310C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA27B20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UPepCcUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA27B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeICN74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:59:56 -0400
Received: from mail-he1eur01on0128.outbound.protection.outlook.com ([104.47.0.128]:48365
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbeICN74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GV4R+JxyR7XDJv+7kvIaxSOFpSgzRUDuW5ER3fvdgI=;
 b=UPepCcUjdfGSJTm3a+tD6i3qtDzeiNc1VVHWXV2mcsjv/KekZnJiDXgpnaykIw6pBC8ziYa5Urtm1RBGTMO0P5ENG8pz4h3XKRlNClnSFUCOkesRq+DQGXO96PST+IaSJGghqB6bkxnVu1mzv0iuqTsG6Zu/0nb8HB1INrMHpO4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Mon, 3 Sep 2018 09:40:28 +0000
Subject: Re: [PATCH v2] arm64: kasan: add interceptors for strcmp/strncmp
 functions
To:     Kyeongdon Kim <kyeongdon.kim@lge.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, glider@google.com, dvyukov@google.com
Cc:     Jason@zx2c4.com, robh@kernel.org, ard.biesheuvel@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <1535014606-176525-1-git-send-email-kyeongdon.kim@lge.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <dff9a2f3-7db5-9e60-072a-312b6cfbe0f0@virtuozzo.com>
Date:   Mon, 3 Sep 2018 12:40:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535014606-176525-1-git-send-email-kyeongdon.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0118.eurprd07.prod.outlook.com
 (2603:10a6:207:7::28) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 579583a5-0b22-4f63-7c0f-08d611814943
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:XEXiK4TRmHHrd/CwrD4RG0N+nxE00ykIIl8gaszRWH5mqfXFgK8/SV3ZDS4ptkdn90wi+56+rhKfnlUvKcpU+dfcGogP0BWJHj4uTszMFO/TE5lAVw5/fvjZbfhCWq652Fg+WwmjH2S4HkpmQ3WycCUlfrN8FRIBN8mIcJCtMvOT+i0h+WVFIAZcjztV78Ge2bfrXnQvS50IQXfaLz7vVTbEBXGnoPxP5UtF/qfCY964T868HAiu1/50oFWWYM5j;25:IPJR+t0SN6rniM2gjC8e57YH4ssBJJdCbpluUIMICXXQkZ5fyfENYL9sfdcJ+cioqO5Q81S5ZMozbM/DIK54c6JvP7pqlAZn3QF6UhhESAUBqiyMqaGv+L+QNQdK6Kne3B8NWn+35ZjbY/PD7mg9QIHfthxpxp445B/sAk1Df41xE6zumlXVpTP4dQRtACoI2+BBsh+q+K0o01FE+fCt16hCFUVfoIvdWnSfq5x30d6pSQHEkDM0V45gn1oo7YJxFiSCCmcW9pLczNuZ9DbFl32bTuSISKX7fYQj1eWs9jIwYEN77C4/wFfOVr9tkPbHFVgKy0t41fAMHvaUphTAZQ==;31:PnNS+MmEvqLOpzscsP6HAjrW6vLqdpwT/hoX/xItv6JWbukbXJXXae9nj8VCumBRNlF60F+gZ0UENK5ou626HqlpizOnqd56xkqGoSbdtuC2ZjGGcZQxvDwz4rAJauNBi73oMIOtP7GaR9eK82S78osMHF7ecz+Do0O05xRIdL/bx2fFUiYIXaaxMx79PktYEgNemLG0g2+crO2KVF5N0cg+cKrjCc8aV3uBItK02vQ=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:vvJPC8YNzN4mQ+uDC9s1HWG17SuWE0XZzhBBG2vWUyk4bnr8XDaU3lsWS9Fh9ThSyNQViOPBUJBIV7R7k2ngiA9Jl6H3HU+wWN5eV2EnGvZqRnLeryrmpbh5EbsXeMnaSz4B4TIIHN/S9SFXRH3dNJbTFnoISyFg9jWEyhYm1WxUfCXGJpgt88IPAnrwByfCJE20maNI/iZ/Nem9GccuwJ61m9rOz5FXZuttbrYtw4gDH/XdnobI8v+XODlJGQt7bvycdgqNJvtrgXy672qTpUFy7iiXVL53UtYsQHa+/WKknQKlO8aIOVvn0IfLTLE1zD2m/AmnWex8S1YvnLO5oclyz+TwYrs6ueG4/RyMfx2nj+ApuB8jLADZdpU7yM5gp8zm1bE+ep5JjCJ9ZRiXwUuLdvYDb7jTjd50jQhyjDUlmeBoWlsuIj9+U6j+vy+qf+sxd7+0xXreyI3qRB/qjRKjVwOcFJTkfec3E4e52QyftoqAbsL0RJQF1pw7o3B4;4:dnk3ue3P6f3Zhla8IDoj6/894sx9M9HKJIhc6CcVMxgxzLETrZ+Fq3H6klfwZxGwVEC3dREqw25kRIHeSd9JRRvUAr4/p6CGtsUMSyNSjjf1wfAEBh6MSCH63B92ihLZc4T3EBVKASKBS2UHxKm26XBury+IQ9Ps2p17hqU2r+F3W6W3252Z60BqktdspchJGHrC5HrRLE0U9I1wtVXu9gbThq7T1nBWW8pq/2HMzkrvMHeVXJUQmmG3Ei4OrYRhYckIiB687AIO20i5S2ylhQ==
X-Microsoft-Antispam-PRVS: <DB7PR08MB32580FDDF5B76C6CB652AA1BB00C0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0784C803FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(136003)(39840400004)(396003)(376002)(366004)(199004)(189003)(230700001)(53936002)(64126003)(6246003)(76176011)(81156014)(81166006)(97736004)(6666003)(8936002)(478600001)(105586002)(106356001)(50466002)(58126008)(2906002)(16576012)(36756003)(5660300001)(6486002)(68736007)(65826007)(316002)(229853002)(14444005)(23676004)(25786009)(2616005)(956004)(476003)(446003)(11346002)(386003)(53546011)(305945005)(7416002)(31686004)(52146003)(3846002)(4326008)(486006)(7736002)(52116002)(2486003)(31696002)(65956001)(65806001)(47776003)(16526019)(66066001)(26005)(77096007)(186003)(86362001)(6116002)(8676002)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOk1iR0kyZXJlRjE4K0ppR1o4bkErVHp6cGZh?=
 =?utf-8?B?VUlyOG54Q1RpbHpjbVRqY1pyRVlXajI2WE9GSmZJdUVxZDVycDlOc09ObVlO?=
 =?utf-8?B?R2JGRHhGdjBFUkZob2NkeXVIWHBMSHFrRjBVVkxVT0h3SEZUK1ozUEdCRnBY?=
 =?utf-8?B?bUpleHkydTNOVVhkRjlpT3N6REEzTFdFdDY1dzkvbG9TeGlNMWcrRHR2L3Vt?=
 =?utf-8?B?cWZIbWNWQVNpcE5MTUtIVU5pUk1nK0Jnb0Z4TXlaK3BTWGFiT2M1M1BPb1lK?=
 =?utf-8?B?OVJESEVHZDlVVWxPemd2ZElpQzgzemxOMjVPUEtIcTNwQ2hGRDBRQnBvSXln?=
 =?utf-8?B?MzAyQUF4eHRFTEgzOWZQZ2Z5VWdES2hETnRvWm83Q3hSRGRaam1rZVJuNE8r?=
 =?utf-8?B?empBMTduTjlGOVh0Y1BZajk4TE0wOFlOWmdodmpqc0ZGSERxZ0dKVnh2Ylho?=
 =?utf-8?B?eTNXZVJoUHNZQXRxZE00VDhRVTFld0NsS2c0MlJQYXh5ZTNjcTdZVC9tUkc2?=
 =?utf-8?B?aVlZUExZSmFubzZ5VWFSNnJQTGEwbmFsVUFjMzJKbVFaTGcyOVZmbEE3Zm9X?=
 =?utf-8?B?Vjk3d2JzbXVMM3pxTGFERE1IbVFUVDZaN0tXY2x2TllOSTRZalIycXJXMnpk?=
 =?utf-8?B?VDJ5TlRIMmVpNU5HWDhZYjNXSm5uTlF4dVduaERrODB4TjVwdGZzaDdHekZV?=
 =?utf-8?B?WW8yaDVlVm9aZEtQSzhFTWt0NXZGSlpsQVdSVTk0TFh0SnRIM25BY0JUQUR3?=
 =?utf-8?B?bGc1aFo1cnZ2K3JvOVRLdWNZbTdSSzhjVVNLVnUvWnhrdkRZSUFybUQ4ak5l?=
 =?utf-8?B?VDRNa05oblEzVkZLdEkwSGlpd29BTVYrTGdIVXFQWjNTc3NkQjlGd2dFR29l?=
 =?utf-8?B?eXYzcW1GNFZweDB1YTcrRHFLUk9XNzZnL3RZbitLTGgyMDgwUHQ0Y0pKTERj?=
 =?utf-8?B?blhLdUpqS3VEaERTSWpxQmRUTmhySzlJdmJBNGdqYWR4Z1hVNGFTU1pzUEVY?=
 =?utf-8?B?VkdRQVV5djZwYlVWODhtcVFKZU5hVHlTS0tQajdKMGxJb2g3ODFuUXFrQlpY?=
 =?utf-8?B?eHdXYU9aUGdTaEhDbzd5ZGVDYVBwWjZta2k1M0E0MnYrVWZGM0dacVYvTTl2?=
 =?utf-8?B?WW5Zb2NZRkZrYnVwT1N2YmNLVXBDdklleWMyQnh6OGRmYmRDeEo2eXFjRmRJ?=
 =?utf-8?B?UnRTUFJ6WThXZ0RwblpkSTAwZVREZVFiSHB1Sk93RUkvUHFkWUR6Uytpd0VW?=
 =?utf-8?B?WmFBYUIxcEh4UFJBUkZNZ1Bvd2o5dWg2Y2VtRkxtWDNLbzFzd0d6cHY0eVo0?=
 =?utf-8?B?SmVxR1FFSU5CTU1LM2FGanlkVWMxd0Q5QU03cllFem9xb093QWM1dGppeE8v?=
 =?utf-8?B?S0J2aWpIbUhpMEduTlo0VzVkZHBLZUFDcmw0eitEcjcwMGY1WnZsTGpHcnpD?=
 =?utf-8?B?bUV6RWhhL2NTRjN1WnJjdUNsNHBEZ2RmOTQxVXk5cExLYUNUQXRYWUtBN0NH?=
 =?utf-8?B?YzRDZk1ZZEowWGtnekNlMUFXSHlXaGJ0Z21ZWWJTS3hMOVNZODJ0NVd3dVFi?=
 =?utf-8?B?c1RvRUNIaE9jeUZYSVBqQnJLSmR0dFc5UzZJOHprc0t6aXJBRysxbERUS1NF?=
 =?utf-8?B?dzFVQ1F4ZVVMY1VDWUJEUUlCbjNVZUVzS1ZsQWgzM2JqWW8xMmVQNHZ3L2FI?=
 =?utf-8?B?SnYwKzlORzh1ZWZlTW0zeVpFMUFwdDJCUjY2TVlLT1orN0hYdkNwMTZ6d3BQ?=
 =?utf-8?B?d24vQ3B1WStrZFZqSXhRNHcwRXJ3d056cXhnWFd5SG93ZnZZSUJvRVVjMjh5?=
 =?utf-8?B?TCtFRG9xdHgyRW5kQlZocXpnV0NVM2o3MWRrendlZCtrUkhXUVJaUVA5ZkFK?=
 =?utf-8?B?UVRhNHdEQ3BoZEcrY0FqTkgzSUZxMHVORGExUGQySWQwVmU4Y1BHTWszZHBU?=
 =?utf-8?Q?wUrDrN9vSdRPEoSWL7WyEs2JNf+lAo=3D?=
X-Microsoft-Antispam-Message-Info: XsxJ9DGT1T99PETTZPPq72cbG9vJxeaEVXnV7SVHWcpCCTfFXmTtssl6Ze018Kh8G7JukfjtAMFqH5i6eATlmLC88Lw9zvgch4l4ymKTcx3D/idDxS6f5xyqTjIClExU+4Cfhjt5OYAMqozQjb20jzaoVosRbljWfSjBb1m0KAscz/1S5FKlixrA779rNakQhd2wHZBqQv1e5V+3fOJTyiO9YBl4gSUwVbAcGLKB02he1qEzEPSRH9fgmP2AsGQOrLxg7Jmv0oYKzy0IT2UCbnBTFcw2oe8r9mGen4m7ZDlWqZNCOm/a5wPNOAkioYiKIuOiXUFlDACJhIQcHkdbAS8pDI56sJkG7r6/Rly0Ras=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:aI4iFE0AvYtx2FtuKFGKxag1EgwpVIYG3PSiDmyfDwIRO0uuAd7Xzr2DSODyme4e7J0dPQ9E1uGvl0VvLgAKZlBIqVAoKuQM86DcS8yFDM9q4Z14KMQX93ZVig0KjJJPRXaxYTM2xM4TyrPpfSkM4hxPXYxq6NkFpd2kPbA1KwXigiUN+2O/HA5yDjl9CRV8it0SeKEyeLvqLqqYtvdYI1uMVuFTvdc6wx3cSvnVZc7ceyc1O8lBM2wOU/5QZ27Ov4sblRZ31ZONh6rJc832ZheZSemtnnwb8fTuf9urWHJ2swuZW1dm1ooxWP8BtMkXSFhMYwTFe2ubJCpaVf5RDR7rV7g9QGh2HE5LYhXoeVMZrZZmQB9O8GWwHyJ4PjvPpobAKvocAv+S2ABZCUmmVWPjIFvnaICTLmLbq9+UkeaMMh6sOYwfGDscY/xvahOiOlU0uSULh9to13vYBFMvHg==;5:CAI6yQ1zw9VCmLozvZGorRg6nqRCK2grvftSK/uklCey4JF4zhvb1GBGORSh4rD6uettIIBvG9tJt27/bQsvs1ki8UavIQAo1QaC6jhIFszHjKRbAXc/HAcCmW4Qr2+nSbVF/hHTO6hwLNtrncnI7kMPqzoimX84cwYAyM3hN3c=;7:YD6m5dKV1zG4khOiqYz8Oty1K/EyOLVQyivuFbt36rGg6Tt2a0cFKPg5Oigx3eSal32EKbiyKgipgypv7VeKK68AGAStHwqPZcacev3CDGcuHo4xoSq/Q0jF9iL9Avk4OAdVSKVg/iDkZspgT97HVRr0amqPwzm6JVoASok9Mix1abz4Lr9DERvOa5N7p99re7/ETEnygu+v2OzuXCxAAuy0H68l47ZYyYhRBUVyxFy5Bp/F21mCdjSmYwpWZ35n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:zcGhb69icutK7bhhOrhcZJpWdio7QPZIGslKMXEwLh/dKzbfUeD50qoaF+S/LYHRlFpZIDiazN1MW8X59LK5KVSz3H21sfTdZSeNuRL1YA5UsRsuC4Yd9OuEkXMq072Nb93bprlsJIMGW5lGxmTEC6EbJauVcpSJEfhz7G/HbcQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 09:40:28.7741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 579583a5-0b22-4f63-7c0f-08d611814943
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/23/2018 11:56 AM, Kyeongdon Kim wrote:

> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index c3bd520..61ad7f1 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -304,6 +304,29 @@ void *memcpy(void *dest, const void *src, size_t len)
>  
>  	return __memcpy(dest, src, len);
>  }
> +#ifdef CONFIG_ARM64
> +/*
> + * Arch arm64 use assembly variant for strcmp/strncmp,
> + * xtensa use inline asm operations and x86_64 use c one,
> + * so now this interceptors only for arm64 kasan.
> + */
> +#undef strcmp
> +int strcmp(const char *cs, const char *ct)
> +{
> +	check_memory_region((unsigned long)cs, 1, false, _RET_IP_);
> +	check_memory_region((unsigned long)ct, 1, false, _RET_IP_);
> +

Well this is definitely wrong. strcmp() often accesses far more than one byte.

> +	return __strcmp(cs, ct);
> +}
> +#undef strncmp
> +int strncmp(const char *cs, const char *ct, size_t len)
> +{
> +	check_memory_region((unsigned long)cs, len, false, _RET_IP_);
> +	check_memory_region((unsigned long)ct, len, false, _RET_IP_);

This will cause false positives. Both 'cs', and 'ct' could be less than len bytes.

There is no need in these interceptors, just use the C implementations from lib/string.c
like you did in your first patch.
The only thing that was wrong in the first patch is that assembly implementations
were compiled out instead of being declared week.


> +
> +	return __strncmp(cs, ct, len);
> +}
> +#endif
>  
>  void kasan_alloc_pages(struct page *page, unsigned int order)
>  {
> 
