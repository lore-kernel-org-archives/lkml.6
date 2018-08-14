Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B4DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A76E21729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EisqvwGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A76E21729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbeHNMD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:03:59 -0400
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:48960
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbeHNMD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3phjfJ5bILrbf494De67DzsAtM1Knl5wu6bOtJAy+jI=;
 b=EisqvwGugMHbuhUjMj8hX+Vu4EqetjZIpsS4gAKGM6R0i80kDLl4ZR526rW7ltGKgx+s23zNErfBOJh1nOubPR+YtG2GIOhzxUDnRWqAmvMmJg8w1mgqJKVFd+rlCzv+uA8gGCChLuFnTWgFO4fiz5jKzQJKcccip6uDp4Wd0Hw=
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 DM5PR12MB1722.namprd12.prod.outlook.com (2603:10b6:3:10f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Tue, 14 Aug 2018 09:17:35 +0000
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
To:     Arnd Bergmann <arnd@arndb.de>, michel@daenzer.net
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>,
        Jerry.Zuo@amd.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>
References: <20180811155554.3382650-1-arnd@arndb.de>
 <593dd8e1-fa23-3216-3550-274401d88bcb@gmail.com>
 <CADnq5_PCyKb72-BjFG3B4p_+bctNKoswAibw8C687_fpystSJA@mail.gmail.com>
 <CAK8P3a1AGC4fFYSSDQn2snkvf5htZVffCwRLV1NBm5YeZgw+CA@mail.gmail.com>
 <632dceb6-27e5-869b-46a9-6b11944204fc@daenzer.net>
 <CAK8P3a3fDOeNWsmtXRHOF5cAMit7AMt7fS_54m7NXN0AjZYbPw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4bc1c021-e976-03f7-c442-f7ca9804516a@amd.com>
Date:   Tue, 14 Aug 2018 11:17:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3fDOeNWsmtXRHOF5cAMit7AMt7fS_54m7NXN0AjZYbPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: VI1P18901CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::16) To DM5PR12MB1722.namprd12.prod.outlook.com
 (2603:10b6:3:10f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec0c739d-38b0-4082-a2fc-08d601c6c75c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1722;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;3:CWK9u1EljrDHFcCW1JyBGQuLba2IZpvqCPBriZuBpw01ULr1ZBhMtGaQ0RuJdirIquXHklHCatrHtoAGOlt1yp8QVPPYQ67qLIY8Vp+FgLKE9s28oDUkr73M56FBiY8mBTAKIKpiD80QwjeAtjkMIrRwFva2WNo/+igX5FRtYKl/lAkp4d0AD36Z54M9WNY1aGgNK4AWMrx1hQezY2lGItVUd0sxAKfNTMMfBDSShy5au61cpY8cXoNkmnFTo+Lw;25:u3k1FSYOTcRz0Y8P3FkzAm48/iH/itdWsSMhfJ8endx1RYDCmwF6NY+L47Av1bdO+CEeVLmdMFMwgfDBbxAE5vsR563dflgt0UJ0L9IukBod/yTV48hjDAjwIqzy6pyRY+RgzAUfjxRVZjnenaOKpnEDEQ0xTIX2zwF/AKMhksQineWrHmbPK2tTc0ZsuCF4GOKgqRyGkvhKjHyYxjLLHtJej0qfEPIPU40SyR1fiW1cGfka+F1NVPyvj05DBJ6FNSJtoqNeD2Z8puygz+KyNJIi9y8RQGx08cofBzwDQbFzSMVuV3Ei4gAFrrvfWdae3VOuYh5YFY1pQ4RwbA3rrw==;31:jLkamEzMYX0HWjJeVTUffSkNm327ywW3fXghAqAAGB+f6qIe1dXjCQxjVziJ0FV5xdC0zGSLRrZpA/JrevKkl7nyjfnZ7LFoSXJZGQJA7g8AjYF4lXR9mv0YhrcVzvv6LONHrFfg8EXeWmbi4BbgyCJt/CeMdLnWpkPxlFYY2aQb6romWe2AcQDc6W7rNoVZbi61OJMGhPknlz4OnaHMjPG+rQM3xR1NaLTkRfXVkd4=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1722:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;20:I9niOXV3ULBwdCFRuhzQKthcpza3lP/3oIK6pDgUNzpmeoAEBJVlLOoq68ByHP/qZY2a//ypl3FBIpxoU1NCMgGoagI122CK6mtgdu4khHTxf5jAlFFLpjKzWOj0r4x3e3rTu4+JxUEtcjmCQRSpfoNOEkxJugnZ6qAcbztUpOsymRyuHberSg2rzcNYnGbEwbhL+/yKmFLMU6JID35ds6cGDehQrrnt4OwoUdoKEBVtUzgtCQz3FeNJv/WQSO7l1mUE5qT2NxA+p6GI8/nz0XR0ZiGggEEMewoWK0fZ+WyYaapOyFfSSs+uFW4Dlz6TTeipIiB32QF1MmWNaLtUDVeX6brzXxYv62qOatJ1DQrPnScld8jyTs8vnhVqKHrKmwkN06iYjYl3RUZkxHBW/lySvK0tH+GuErihg1PxHykeNhTZcFp7ZoxcB6aTBpF7K0bdsQLJfSmGO7HVIOM0PIE4KrDmG8Fw7VYpHal5nX+2J9zErE3sKP+Zj3dhG/ZT;4:1+W1sV/CNGwtYOozQvlTsDva4Aoe2SHEHpCrfrRdQkSZ5eJTT0krNJwf/IHn2+AYtO/CJd8my0Pm6XWWHMBUkALF4VbaVw8PxIYz0uTC0j+/3sm0Jnwr59QMQqYZRBMnH6xz+8/3BMlRUY12K58EGytwmyoHBRh/cLQrS4829ICVEf8mkBbF6wBkVovmIx7iK1jjShcnzJshzWDwHrobCn7uptprHbKIiprusMXEmIbu0IpKHOVYODxInpCrkB3Bez6fYCka+K+6EilMVHl8rYNierzRufmCdxbVYUJW1RJG4THSfpdnvBPu4mP5OUogpUzl5LUeoaxIZGXZUQ4LqQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB17226A45D61503B266FAC26383380@DM5PR12MB1722.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301033)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1722;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1722;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(39860400002)(346002)(189003)(199004)(53936002)(14444005)(486006)(76176011)(46003)(31696002)(446003)(16526019)(11346002)(36756003)(6306002)(2616005)(476003)(6246003)(47776003)(2906002)(106356001)(67846002)(966005)(97736004)(105586002)(65956001)(65806001)(39060400002)(31686004)(72206003)(2870700001)(478600001)(93886005)(229853002)(316002)(5660300001)(25786009)(6666003)(68736007)(50466002)(52116002)(6116002)(58126008)(54906003)(7736002)(6486002)(64126003)(305945005)(386003)(53546011)(86362001)(575784001)(23676004)(52396003)(52146003)(2486003)(81166006)(81156014)(1706002)(8936002)(8676002)(65826007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1722;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIyOzIzOlI5clRiNC9oK0lFZDBMdXZxVEtmZTJIdUll?=
 =?utf-8?B?TTM4dFZYZnFRL2hzUk5yS1ppK2NQZEJQQUV2RFRSMm85eHhWTlpwdk5yRG0y?=
 =?utf-8?B?UzQ5QmQ4bmliVEltZFVqTDBrcGdVbDVlclZBb2MyUG50cnVjTklkZkF4YjV1?=
 =?utf-8?B?MzVCYUdacXc0eDFLamFkcFMzbDNOcFZCT01xTVFUTkY4RXZjTUVjdk1xN01C?=
 =?utf-8?B?UkprcVVIRGNjL01ta21pOEJJSlNHd28xY0F6U2dmUzBqOC9UelFUZkh6STVX?=
 =?utf-8?B?NDdGbmtZU0djZlVnMkZWRmV1bldvbmIvRytwSTBJYWZqdDd6cTluSERWSWhI?=
 =?utf-8?B?MXZvNVlYUWUxZE83MUVwOFRPNGljTHdxeVNyMWJ4VEVhWGh2Q0FscG1jOVBD?=
 =?utf-8?B?QmlMN09sbVFGVkV2YzhjZnNxVURhY1JtSVdWSitKWmlFTVN1UC9YTEVoRHd3?=
 =?utf-8?B?RmNtcUxJRm94Ukc4cEJxQlR4cFo1NjNKTnJ3VERnSERnVWEvVGpXUlc5Z3hH?=
 =?utf-8?B?RDdMcHlWSU9kdmpnOFRXZXEyWGNrME11Y0NWTkpvQTRzandzMDdsOVJWekgr?=
 =?utf-8?B?aG5TVXIybkl1SEtQYXR6ZmRkS3k3QzYvNGQycUVuMzgyNnNSR254dXA3R3NO?=
 =?utf-8?B?RWdYeXJ3SjZZazkvM3I1ZXdqVjVOckFUTWRwWkljVGcwWjc4ajhESjl4a0dS?=
 =?utf-8?B?S0xOTVFXRmd0cDRGWWMwaW95QlBIQlFRcy9xK3RJc1Z2U0dEN1ExWUUrNnpD?=
 =?utf-8?B?MmY4VlB3R25URUF6YUFabHA5eXkza2MzVW9oYU5uampISnA2U21QRE5OcVB5?=
 =?utf-8?B?V1V6RStrblloRWpXS0xiajNSZFN6R0dIenhWWE9YU2JacThXRy9hclgvYW0z?=
 =?utf-8?B?dGFMWEx5Y0g1bzRqdTFCbG5mWU1XV0E3L09yTElVY2ErMkhLV2VaUXViQWcy?=
 =?utf-8?B?ZFdZdFg2MHRjUnBiZmtqSkFYRzR6VGszR0ZYU1h4UWx6Vm1oSWZuT0hwWXNT?=
 =?utf-8?B?Q2FQSENxVTQxRmx6RGpndkxnRnExYjgwS0ROTnhNNU00SWcwVnZ4Y01Yalhi?=
 =?utf-8?B?YjBrUzkzNDJ5eDdEQmM5N1Ywb29LeWtIbURQT2czVE1TWkxJb1lpZFVSZjB2?=
 =?utf-8?B?UllKL1ZqMUswc2lROHlGdGpPOW54dUV4UWEvSWhSeGY0UkxZMTgwMUZaaWNi?=
 =?utf-8?B?dDMzMU9YVXpwNjZYWS9yNlNOY0hOaVozaytqM1FZcnI5b051ODBRam9FQndy?=
 =?utf-8?B?NjMxNS9jb0NYOVgzV2JtOWpSclYway9VQWxjVnJzU3Nvc3RvWUZNU1B3ZDYw?=
 =?utf-8?B?dHZVM2phdVlrcFZiUktlR3lZR0tSTU1oR0lzQndicjk4QnU2NzJ3TlRYTXFo?=
 =?utf-8?B?cU8zVUUxWjZWZUVGclRIMFRJVE9yN0pKejl5akNKbCtRTTUyNXpvM1FnT1pn?=
 =?utf-8?B?WmtvVGw1N1lQQTJFME5JRWN0cUx5UzlOb0VnVy9xZklta3hlQkNFNWw0bmYr?=
 =?utf-8?B?ei9aK0I4cmY2YTNQZWtSVmVSQmxlR0dDWWJoKzM4Rzl3aTZ0Y0dQSHVScW5o?=
 =?utf-8?B?V0MyQ3BPMnNlMG5pYTlqOVhYUDhXSjBWNmJlM3VhOUUvUlJpYXpRMURWOG9j?=
 =?utf-8?B?VU5STUZLYjNZck1MMnl5ZDhmbUlmU1VpME5hNEZTN3IvS001aU9KOEJBVVUr?=
 =?utf-8?B?S3FvU2hsZnM2b0NCczJ1OUF0TUxKWitJTXZUdmxFRW1GcjFLS1ZBK01STFpR?=
 =?utf-8?B?dlFDd3dscjV4d0RjMDZBSlE3SnJ3WmtHNUZOVlloVG1EKyt1ZzQ2R3pBZDVF?=
 =?utf-8?B?Q0lJQ29mTFJLcWlCQ21nT2Fic250RlVZd3hDdjkySXFEV1dvNzBGaGEvWXBZ?=
 =?utf-8?B?MCt4SjZ1WnF4ZFU1T2tscEs3YlJsbEZYeGptR09PajQ5clRtZXhkQjUrcXhH?=
 =?utf-8?B?azE0aWYySW8yT0ZCOHNRMTV2MmJqRndVSVkrcG5KWUpYdzlGRE1BWEx1b2Fz?=
 =?utf-8?B?SnlsNmFOc09rWE1DV3ZhKy9WZVFWRmV5VGJ1Zz09?=
X-Microsoft-Antispam-Message-Info: B4a3rIZRcqGOD8RB6Mwwcafevle0OPs/KXC86vXLphFPnR7GIQLskjulC8FKQhX1tXB3GhG4bgLghHBfMgB9bKrFgtA2fRTqu5pGA0C+VqKGq3wzdWBiQ4dZlAxCvLbRl5qQRhhADxcsavETRq8STqlZhVq1nR2tCA+YYoG3dVBRpnSOzLNJXVvGkfEdElGAh0DQ7KaDn3DDyISWd3YoqF+ng8A5L8RKcXYv53bVNenmlVgJd/ZBoFme1/zXBdw6BY8/gI0GeYlBNuoiFd7qWXSIaX8NRGIv88u9zqi5gT7RMnMz0yiYOi5FGUKAPUNCUqU9PdUQ9uTijH9fmgXUaOByMA0mVzcLm4YWBbyiiro=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;6:vOloirHqdl756loH0zoFX5gAnhgYvrfxpENljkrLQqpsvxnHXHtztjB1fJwq3QH8suqHFbY1NMhlWgOUOwMM+GX3FZ1bMtzrCUt6oFs+0wxXl3mc3oBXYgnKlAGJ5jSYyVfMoIZIm30hOsUu/kHvzqHJQqb4mFFdRBHeS57Reiq9WyUhm3e8MBpFpJPkRuCTA604vSZWQ+7UZBtCyLtK1ls5MjutMfOFkQVY1KupvSaT+EuAtjgcdBb0+WohhhBLzkvzlLKg+ziS4vRHVGfg1nEtRZx3dDjJCw7LKTJhdRBwHC1yEr2NGTBdyFybVIk8WRB45L8zeMSASFZTxrOh1gTtYY8ygUm/4wRhHg9zSQphqrqFm9lxFafCYvADvmcuR/D9XUJ/xgRfBRlsoLkX8aUWS/UEhFkYjMrZcvNuF5pFBBd31rLwks6hnm+qZscD4bSHI9RGlw5gktTuU/xkYA==;5:8xeMwkoPP5ZGf3MnsPFvVfAL21SSGiSfC5JSKyukNrORxiOR2SrziZpwk8kSnORbf7rR3YMtQpM24zmhXl9vWGGN91OdIO3KMml9TRe/lM2oTJVNu5xDWJ/35/zhpf/f57Av+lEE+S4xqv0M2fky3VMIs06SLmVhwM8kK3tXZy0=;7:WZyZyRT9kaP1MBsD7oMROsG53W5CZ7+0oVUoTB2qlperHPh972rYxPAMd4dWLgBQDdDoxlnnYDdrMmDGMUwpG5zpMV6R7jO1CQ28O6iZitaftf5EFWUIMzqMpdp1O8iHQrb6hH7VJfBE++0eetfS6A8pNG2kWLUzdY2pI73Zs8GDgTJMHrYY+D8UuL0LJ2C9tIopd12NbgS/DIBnIpsjaAhKtDjQ3P9irnHRoYmgCAWkmuk6Eg0rE/ZpolQoN2la
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;20:HXyBki5z/dXXvno0ru7ruthwaLh0bW9e1YzTEsWfTwTZeiXjw43baviAFvWMyoICPyRY2CQNGS5Agz+FPTprlpX1DvKW843Snp/qP+3oMXTsZ1U+VkymaXz0WP8LhPJrvzTypWmNc5vyS6e194iZ6ytNtEKGHAiqXHOfDGcKm4D3XMBqtBrNNLIgih3FtgUQPwbJpbQRlHKsP82/EDQ+5XAM/dAI9nF9JoNuGCBQ+E450GEoRdEManftb4vivXOk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 09:17:35.5012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0c739d-38b0-4082-a2fc-08d601c6c75c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.08.2018 um 11:15 schrieb Arnd Bergmann:
> On Tue, Aug 14, 2018 at 10:54 AM Michel Dänzer <michel@daenzer.net> wrote:
>> On 2018-08-13 05:23 PM, Arnd Bergmann wrote:
>>> On Mon, Aug 13, 2018 at 4:49 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>> On Sun, Aug 12, 2018 at 3:55 AM Christian König
>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>> Adding Harry as well.
>>>>> Am 11.08.2018 um 17:54 schrieb Arnd Bergmann:
>>>>>> Fixes: bf2e2e2e0ea9 ("drm/amd/display: Limit DCN to x86 arch")
>>>>>> Fixes: 4841203102a3 ("drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86")
>>>> Maybe it would be better to revert 4841203102a3 so we can limit the
>>>> scope of this to DCN support.
>>> That would help, but we would still require the patch at
>>> https://patchwork.kernel.org/patch/10090227/ or something else to avoid
>>> broken randconfig builds.
>> FWIW, please don't revert 4841203102a3 in a way which allows
>> CONFIG_DRM_AMD_DC_DCN1_0 to be accidentally disabled on X86 again. If it
>> is reinstated, it should be strictly derived from other options, not
>> changeable by the user.
> How about making all of AMDGPU depend on
> " !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS) || BROKEN"
> then?

Well, certainly not a good idea.

We don't want to disable the whole driver just because one broken component.

Christian.

>
>       Arnd

