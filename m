Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2056EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2EB20892
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nFSgPrDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2EB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeIJLxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:53:18 -0400
Received: from mail-bn3nam01on0062.outbound.protection.outlook.com ([104.47.33.62]:24336
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbeIJLxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+wQCHMMyIMtAZqxjiXFvhBtmG736ul/PT9T+CNWKFs=;
 b=nFSgPrDypGxHwF/TrI1FyD5RjmEybdnH9Z6oYjd0SPFb0CHpk1Ft98EbneXSZZNtWjVR9+1EbbWyimFpgf8s5+WUm2bPTm8q7qstYh5WJrgZz40jvYODJWAFB8CUJltpb5rgx2ViJX8hqGgBniBpg1VnwC5unVBOoFouiR8hpRg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 BN6PR12MB1714.namprd12.prod.outlook.com (2603:10b6:404:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Mon, 10 Sep
 2018 07:00:32 +0000
Subject: Re: [PATCH 0/2] [radeon] Getting rid of GUP and use HMM for user ptr
 features.
To:     jglisse@redhat.com, linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nicolai.haehnle@amd.com>,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20180910005753.5860-1-jglisse@redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <28acca28-7df1-2cc6-a1f5-09c6ae90acdd@amd.com>
Date:   Mon, 10 Sep 2018 09:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910005753.5860-1-jglisse@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: VI1P193CA0023.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::33) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dac48cd2-7dff-4f28-0b77-08d616eb1b0e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:Mayf/Jw8riCD+qYhZoy7T+imc2hlTONq+FsesIkMTvpSqmjMUURYdH+HH5PqH5QeIWMYei/c8hGtr5JH3fS3zN22heySksHISC+KMGA0+lImQZ0gzhGtKUsIXJTdRAO1RFPLqIjOF05eGEWZWeIZPODIJaC2SB5rh4xCm8P2QoS5W4bvZX8R8JEskHCE0fknxs6GEYJkcqv8Dyj6nXLNcHbkdwlksa0b1TykO9cIAv8W1b6RZ8kFO2Icf8Y6Wkg+;25:vF8ll8oWOQulNwTlDNcrPcacDizafOBXFQpvHtDs1zkAKEZMSPJkHIGXXSp5sP+Qy3qNL21v5SCvRR/M730wSsGPbMaGY9uvVRAe8X2WScwrrZU7+1V/8kQuHcvJPMaijcmF+fqnEXOYqS4swIyaEohnyIbmHtIOFd/LjjfwXqcKKGkl24oknukqKw2PmVbt5PO5eoinhp6tKg3Q6P34W0j6Brp1Zh4pashMOWbh4nfTjlSkqSYA0RRUKDFjnpmDKbiB4A34dLldG1T2jAbqR8JbmDlZQc1YnAv78qXS821UA0UOe5TrjmXzhpoA9hD/JnxaZ/x/a/DknEKJUVcRmA==;31:n70xumYwJLqc2qAIzzEkUPoE7+PhIksIVUJ5VcODReOvdpRmEYphNQCx7BV/+6HTPdXqZbdbWfxPwQbT7sTuko9eK1gfYeazYmrxo9xm2xv1/RcpFBcjcXLySz6JyUb6Ib8yEL+blsP4iXpNlgHVN2/IdvFhqaBe9+w55JD5Ofv0A2WjAc5m9z/haTkGpphRdZuFKUKKGNruP1I6H2Qvs3o5ulF2GUCqtMYNEgzycYo=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:+XUWfnKCxnRHZaw+59bCl7tudkhUDkndMFGAt5uSH+Wifz+9AJZqPbD2AKATCJVUOVKTJSc5JmTDuWVQnibDplXhMxj3cw1K2Jwyg8iDzt6dXWhm2TDB3j72tjoOH1aeHqy4TKlv7advfkn+XBTTo8y7s5BaQ5mAhrinp5xtDxSAB45Lt4j1gEb1FuU+XD8lr6SIht8oONe+eox5lPHWSAbljmEUW8frbvWzhVzTsdHBXch8vqVCZw9NrxwTi4j1DhrVqVKYq0ZYqPn8MJKmW27JNRaA5YQEDIPNfe6qELV+MjVjYMqjuMxymHfmQzXEdJ+4etwaUIo0GbrqO52iz6Mkn7mkmZs6COE7kiRQD8y2vxArVPU7Vb9HBKrl9inIUVFRe3PX09huLXupPfiFDZIzPxYaB+H91OCQftqcxd71KDvj/K9xbmHG97qwjfQPCg6/+5mfiksQPYtFky64GnC+UAKNfzoWpOejo4chd+C3TTJJIXqVfHw1v+HlDiNf;4:1QAqFoMmbODRKf7To2zdwslkNHEmKzPunpJOaKA2NY2JolJzRqsPyM2Hdd7KofE4g1CLB+3Osip2BNzbIO8NX6eXdk2y0HX3V7tPULsF3GFjw16HhyL/Vf78Ms7t8h8Y1aUn5v7qNdIRl0zvQ1hYJr7KQpo2HDKSKG6MmUiKj6DAWc75Rw5PSx3asjfpad1G66ZwjnqMfZxMfG/bEF0Ybi9sEaKdmxVuUba2e5sTd4acBKHPfbbpT9m9TNyTsXYXyhvODIv1e9iqm6KHzVr8AgYGDqSO0wys+eOqkaooSn/zYSROGDscjEiaMIHv1Y0I6yb+X9ujF6HZsKAfwboESx6TRlFqGbo/8kAV7FoWLjk=
X-Microsoft-Antispam-PRVS: <BN6PR12MB1714B5A77CF2DB73DA1A9D1A83050@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(476003)(2616005)(11346002)(2870700001)(486006)(2906002)(446003)(8936002)(81166006)(81156014)(6116002)(53936002)(64126003)(58126008)(31686004)(316002)(1706002)(54906003)(86362001)(31696002)(76176011)(65956001)(50466002)(47776003)(65806001)(478600001)(72206003)(966005)(67846002)(52146003)(52116002)(186003)(6306002)(46003)(16526019)(8676002)(6486002)(2486003)(52396003)(23676004)(386003)(229853002)(7736002)(305945005)(36756003)(97736004)(68736007)(6246003)(4326008)(65826007)(25786009)(5660300001)(6666003)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOkkxeFRaUXhsOElvbW9qc2pyZmVydlhIdnZB?=
 =?utf-8?B?VFNMazJ4TXJJNTg2R242Y3Z0RUk3ckFZWUViZm5tbExMRjYrMlVUajNhV2hZ?=
 =?utf-8?B?Unkwd09weGZnblRaWlpWaEZENjVsaE1WSEtlRy9vWG16K0xoL0xNMCs4LzUw?=
 =?utf-8?B?MzUzbld3ZC9UYmdTS1R0WGZaV0dyUzE3cUsvb292STdZeUNrT2Q0OVIyR2w2?=
 =?utf-8?B?SE5MQi9JTlVYSkswR0s2ZSs5NVk2VzdKamNzcm5TaS8rSUU5b1FBRzFtODBB?=
 =?utf-8?B?aGNDQTRDM1VMZkhVYjNCY0ZkeDQyTU0wWkw5N3JvVnQ2SmxpN3Y5Z2tGU2Ux?=
 =?utf-8?B?emNES0hyTDR4TXJIU0hleFErbmkrWnVkZkpJcTE2bXMyOStlOTdDSU5YVFRQ?=
 =?utf-8?B?K1ZkU2hxSDN0dmlEdWZQUS9tWW9GKzExR0wwYnA1NlQveDZ4U05SZzRmc3BJ?=
 =?utf-8?B?ZHc3dkM5WVRZazFKRU04aHFuaytNbFBzdnZnTndqMmtxYmVVYVA1Yi90MnVK?=
 =?utf-8?B?S0ZYUkRMNURSRHZDQU0zRTlaenhMU3lUbDhJemlNcFo0d3kvUzRXbEQ2TUVw?=
 =?utf-8?B?Qk9weGFvWVdkbUYxazNERW1CS1FZNjZJdjUwa25DN0R5cDBzZHlZY2VncUZF?=
 =?utf-8?B?U0h1alRzYUp3a3ZBMTI2NmpTZlRsMUhOclBuTi9paTFjYlJjd3pCOGNqSFJG?=
 =?utf-8?B?UUk0YXVmaUUyRDN5VjZVRmZMcU9SbENMdFZxc05WOXk3VDRsb1BqQ2xhWlFi?=
 =?utf-8?B?TDFncHU4dDk5MTgwMlRkdlBiQ01IWkhEUXQzRXVpYWNHYTJtb2JNZnlOak9N?=
 =?utf-8?B?dWlTcDhReE1LblZGZ2k0WmVSQjNzbjFUZEs4YW5Kd0cxN2RtNWNLTk9WUXcy?=
 =?utf-8?B?c0kvK3pEU21ZNEJyMDNKUlZucno2cFJtNHZXOGpTeDgzSmxBNjBTbTAvdjd2?=
 =?utf-8?B?WmQrNEhNaS9aTUVRc0d5WG1NUkpUTWtJaTloYlRIano4aXBSTVBtZEwwaVBJ?=
 =?utf-8?B?YkdMbUx5QUdHVTBaS2dsbUZWU1k1U3YrbEhJeXhJd2UwSGhJZUZ5ekdNN0Vs?=
 =?utf-8?B?MEhGQVJ1TmlJcEx0YjdLNUdjYzJFZkpNazBzWjVDb3NlQVdwQldENDB2ZEIz?=
 =?utf-8?B?VnpMRzRhS2F1UUZzS3FSeGxWazVjNGp2eGlrUWtwcnpybFFWTzVoWmZCVlNB?=
 =?utf-8?B?VUdBazZpa3hVTjFNWjZ3MFRtT0VrV1lNRlZzRUpZWFdTZU1aUjJrb3BCTkZW?=
 =?utf-8?B?bTRNUTVpNGtNU1pJcDdNTjk5QXlRdzB5NGJKSFh1dlNVYTFCOFlVSGp4YUhP?=
 =?utf-8?B?SUdGeG9GZUhLWlp5MFdTQWhva1hmZ1ZSSms1R0JCTm9ZSENjMEtVeGF4MFpR?=
 =?utf-8?B?K00zQi9TTnEvT2hLMm5NeFhTMHF3c09JSnV6TjRHdVZ3ZnhhV2kwdVNhcXBS?=
 =?utf-8?B?ZkQ4SnY4OTNkd3VIVVBqdTIyT0YzK0s5Wmt4ZWNMcnh3dGhvcXRZVXRkL0R2?=
 =?utf-8?B?ZURwVldJeGV0RzQ1T01ZNTFtUXVTOWVPWHRadjVjS3lBQ1hDL01zZjBtZTBQ?=
 =?utf-8?B?dE56N3hOcHZ1bEQ1dVlsQ2x6bm5TMTVjZkQ0Vll3U2RkeEJrZmZDSlY0VC8z?=
 =?utf-8?B?YndSTlM3NlREcjN3WjBQaVNxNjJ3VWZJdkNwSDNFK05hR1FqVE5PUmZYb0U4?=
 =?utf-8?B?NnkzYnVheDViZVk3MHRJcWZab2twQjh2Q2JLUWlyaGtuUDF0YnZaWXRzYkhS?=
 =?utf-8?B?cksxb3pJalkyUklwNmladHVZRStwNDdrUFRHNi9tc3NwbS94OEtOSThWVEJ5?=
 =?utf-8?B?dFN4RGcyblFtMEJrYWJWa0d2b2RhTmtjUjVFQXJsdmp5aTBQTmszZjhTcjVu?=
 =?utf-8?Q?nn5DQioVCM4=3D?=
X-Microsoft-Antispam-Message-Info: JKrl/ftOi9ZlAwcL58MMUNSra3nDIi2IOUT4xQRowDFHIoB8jiYV/RBuxzzNY7zkPgDkdOvj/n3Ep8dpJVGai7ss0H6YPwWsUG5demqEqNVDCkMyiTrQLzeMivW0Nf2Z4Qra6E7OUHCvhQmomzgvWVXN9ofr9R5JUIdfKDQ4O1Px7VW+nQO+B7by7tXnbCmbb4EfJeLDTdNNQDrpWepFjuIhStkCVz/B+cHT0/yvGe2vg9A+SRKTDtj2S0K01i8sDaDD0afEThBZ30djfYJ/gGPoFPBgo3WUm4YRekYZO5Y30+93Hy7OKtota115jCMvB3vZs82kcjS8DaTU4tRFkGTwtL2nvJvRwA2DTOzS5H4=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:XpyY/rHdnbf6r3ahmrQNyxyPlJNsLZm2DhEm152uAbeGFrLrZTzz937m07PdjktwzB5tw/1Wj8cohI0GKUeBUN0rbK8Dem3Oac60vpjpERWPnXJnOIhUWWdLxSNb/n0+1Q+c/cxUMrQv2lG7dyA+XAAoXgdfdAluXXC9LGxmRt6YRpgjc9+AOBm4SSWBO4xo2MR/SuDyZCcmxCBnu81pGutbJ81PMIj6LWG0Ke3aNEV3Ubow7w0G3k9ej9BdAfR1tFRfbSxmeB735bLxNcsbQ3DCrNLCXAnpUhB2EKyh8EHDMJ08g6WPoj8vEsfQiou2YmH75BCyIKaq5T45n0fQLITq+PGT7DK28dntpbhak6ZgbuqsrQlHtF1MCKaJTVMI9Wf0MQ5Z6V8rcNWSGtat8CweA1gEPp5ULQnHUt47CBObg3wy4FsbCagu8HrejY6wNB0wLMLZj53d5f/DR/N0Nw==;5:wrsMEqRqTzhS9kGwI6jBfkUPsfiLYcE4eJV/JEPbf07Ogf5jiDuo9uXzsLeJW5k0jtiU3YidSrEiYe9FfcFqBvNiByPWQ8UNKQXlQEexs7zmy7ByogfTEp8zMrDlJkQKnUwwKyMz6JgRJmkPNBGld31SPp/28xPzN6FSi0mVk7Q=;7:O5EWU52XKM7dsXJO9SDueCUs7SM3C14TyelYvxAEB1hP8RHSP11SGYb3mR9KIQAZJlkZLNhih9+D8FU6+W0BRB+wx3uM26a345i5x6Db0yFxWLVtlZDJgdGdENbJQrdnN6t56VnEtcN1SOnKLe8qMP0BKQsvE9jvf9c+hBenJKRqUUPEpg6nZ4WLQh5FxXteVi8gQ0XVQbnmd5YtUw8a414NQein6RPgd4nvWGSdkZju1udynKPI88IaB7NPr7O7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:TAFjsApWeDMWgmJOtjJqRZZ93v3QaOzMG3cJXlneBHSsc7NouVdQpn+pMn0mMTXzM1JmddPZ8TPF5/Rg4lEuf1BQuRCrY+F2W17kIqE6E/VTDBJmK/wqSOnDDx4hR1HPBgjwCSzsSSOLHjLOHIaLv0iCHNmFPwLcqz316uq2fSDb3P8P5JB5mHpT2RGtlu90UID0RIo254rGwonZ6OsU2s5y1iwnbGIZj/2ahia1F7pLBAjY2BTyFnw3wHLB2COo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 07:00:32.8899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac48cd2-7dff-4f28-0b77-08d616eb1b0e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.09.2018 um 02:57 schrieb jglisse@redhat.com:
> From: Jérôme Glisse <jglisse@redhat.com>
>
> [This depends on some HMM patchset queued upstream see branch [1]]
>
> This is simple change to switch to use HMM for user ptr buffer object
> which conveniently avoid to pin pages. I have more things in the pipe
> to make HMM more usefull for such cases (like sharing more resources
> accross multiple mirror of a same process).
>
> Beside avoiding pining, this is also an attempt to isolate core mm
> from device drivers by having clearly define API and boundary where
> we can set expection of everyone and thus having mm folks to have to
> read and understand driver code and conversly having driver folks
> understand mm maze.
>
> This is also part of what i want to discuss during XDC2018.
>
> Consider this as an RFC to start the discussion.

Looks good on first glance, but please drop support for radeon and use 
amdgpu instead.

The radeon implementation has quite a number of bugs which aren't fixed 
upstream and I actually considered to drop it again.

We can add it back as soon as the HMM implementation works as expected.

Thanks,
Christian.

>
> [1] https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-radeon-v00
>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
> Cc: Nicolai Hähnle <nicolai.haehnle@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Jérôme Glisse (2):
>    gpu/radeon: use HMM mirror instead of mmu_notifier
>    gpu/radeon: use HMM mirror for userptr buffer object.
>
>   drivers/gpu/drm/radeon/radeon.h     |  14 +-
>   drivers/gpu/drm/radeon/radeon_gem.c |  16 +-
>   drivers/gpu/drm/radeon/radeon_mn.c  | 283 +++++++++++++++++++++-------
>   drivers/gpu/drm/radeon/radeon_ttm.c | 129 ++-----------
>   4 files changed, 259 insertions(+), 183 deletions(-)
>

