Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB22DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C6120846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k/IBWnaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C6120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeGWG0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:26:38 -0400
Received: from mail-eopbgr680084.outbound.protection.outlook.com ([40.107.68.84]:19574
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728228AbeGWG0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fTTQenhf+b71IvTjiHN5VwM8xGrymf6F3YH4xmiQQI=;
 b=k/IBWnaOhpbTHIP5jCJl2QdQlMl6uStvykkB/D/6oZmaKHw6Kle6lB9oC4kGJGsK+QkJCMOOGj/wEK1n1hSorRO2TadL36DP059XhuN5+7Ir5fAuelIVrZlqBg9M9O25ywYAEFHGhuDzvb/gSjJ7Fo2X3Ixc4GTVmqDQ4ZhLQeg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.136.129.116] (202.56.249.162) by
 SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Mon, 23 Jul 2018 05:27:05 +0000
Subject: Re: [PATCH] ASoC: AMD: Add a fix voltage regulator for DA7219 and
 ADAU7002
To:     Mark Brown <broonie@kernel.org>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dylan Reid <dgreid@chromium.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
 <20180720121816.GD10784@sirena.org.uk>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <50343cff-bad4-7677-851f-f0b818ae7b29@amd.com>
Date:   Mon, 23 Jul 2018 10:56:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180720121816.GD10784@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::19) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94094dc-0448-48f4-f0eb-08d5f05cef2f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2366;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:t0+msmIBgtuSj1I8K9ekp7/WMMcm8V9+Gp0rasHJSAjjdQkcO8oW2TgQ7wNxxbWx+nRfgMcc8y5u64ErSmPAvUxD340QWGzwv9rm+YOQZCPfonl9hCRakkiTi3bmHawPf2YGyCg5078YnatjBBRg/EjbnCpi3DNPC3P1zoh4WSUXWCkUfcGPnvGmENiolhQmWAPi47k5AFcQzp92Kfpx9z7j3CuoCvKvleCcb3+GlqrCnAJhGw0OkNoRrNRFgg/K;25:I6gf92Q3hJlsd6PFWdOclGJPHv/SDXXkenLo92JueAS1D7vhQXcqYURz7lrLY9LHjicf6njFr0HnP7lXAv2QRud3Zc0fuM09Ul0dBgDctx3GgAizaSDSDSmzUq1dlpqH4UfRI9yGkKhxw+PUACzRntr83Lf7Yaxt5TZgqdPH4OQNZW7O6/jR2zUPDWSXA6XRCy9s2jAfV6LXmL1wHtxiVS7JbryQ9nZNwNatWH4iDpBMyGMxVPw1kHrI7VPulAn0v3aPLLCZkCucZAl6Ams1hMGBZGwFFZylyuoY9kLmLm9po4O3xI11usBAeS8OQLES/JLatBBctraNIvBnSg4BAA==;31:mp5DCvkPDyxdmAyemllFg52Y4p5mENOoOhfzkIvwVlRYjmhnJdlhMyZUXP12KfEWIuNu+qqmFkVPc5fmUgmmwKk2oM8cX5xUOUU+D1C9M5Zs3aMp9ZIaTCpts8jRfmtR/RjD4HgxgRkd34gV7wTerC0XFJIalYx5RDF9nYZNuE9cLhb+Nj0+zKEmBwKsMRkUbcMiLDJbYgUnAzTu5YxKMH2TpQcqBVVclG19TaICUj4=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:MzVFNtc2TsRbPudYXhGFP8gJ0cguEtZHRvyF7acFUX3/xIIcr3GLrniRueW0LK74HHmpOB7DvMo2Rnn+VWibB5veJHQfKkkvanghTHVvHKL9f1NmM9Rv29Upi6NIiORNPpcvZPXxy/LD+VAvDJsVYMI2LSAcPMiWuNZKwXrrQToeMtNW1j7wO4FSzwlP3S065tK5Qqa37qqoGGSAmOybJW1wH5gJx8HQyg/vKOKBfXIpMETtAB4sJaX0Vd7oktYxHdUjpU8sEvM30fgCp4b1UMqGhDjENTBt7M8QQPDQ0vht4QHwdaZo9okYzF9gY2cBEpyKQB1JERo0Rj9JjEk906YlaAhQYDq1t9emqcIFg4YWxPBabz5pVmUy/A7l2VOeJgWNGTBuMTNMTXGyQ4KTt9dlb8iV5DSgN8/IBRNgyrUGwqQ6iD0jDiQcrjPg5sIXXD8M8mLF0vvAW19Z9FcDIhDZDNpUzzhZmWtfx/PV/H9b+T0bmE0dAVWStVg5Bfux;4:8hPPR9ZU0VE+XUDazYpCV/mJCs3Qax2PRp5gLjie6m8R80G/Bjlx4/UGFkrffvWZalwduoOq8Q3/jfnt9hI66nAOqmtmJwWbrXH//zpixlp3z7X1CvYPWuX9+ZnLUFuUvHdkiiXiZ8yL2zefWsjxfIoW6ObktYNs5vrr8ODQMfzhorttjp6jYM1/PQnvwzlwOXjqsfGknpXfYRQYJP+wyXW1DtmMpm5EXyvz2tanp8mQPrwwDTO4VYdWxnkRSxlVJU7eMiQPLKLjiAMglRqC7A==
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366EECFA2FE5DE385126BECF8560@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(199004)(446003)(386003)(53546011)(11346002)(26005)(3846002)(6116002)(229853002)(7416002)(16526019)(77096007)(186003)(65826007)(5660300001)(6486002)(50466002)(106356001)(105586002)(6306002)(16576012)(316002)(58126008)(31686004)(6916009)(54906003)(76176011)(6666003)(52116002)(68736007)(956004)(7736002)(53936002)(305945005)(2906002)(2870700001)(47776003)(2616005)(65956001)(66066001)(65806001)(36756003)(486006)(476003)(23746002)(31696002)(64126003)(81156014)(81166006)(8936002)(86362001)(8676002)(966005)(72206003)(97736004)(4326008)(39060400002)(25786009)(478600001)(6246003)(3260700006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:[10.136.129.116];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR12MB2366;23:xpiz4xEn4zlHxjgie3tfZcIlfMUkrF1qEU783?=
 =?Windows-1252?Q?WcGSPjVynH+GAB+Y2DvTKO8Qlr9m+LZs58R/TdCB3KleBqZYBm1O5+Lg?=
 =?Windows-1252?Q?241Ftff5vnmatMor5fLx8D685DCN1mMhVHHIGmxTjdv2MEE64TEvo+gP?=
 =?Windows-1252?Q?Ni5JixhZMLOlccFNMbJxJG2sPjluuH1RBuBNsIcRUKnD8mdRyEOQaBAp?=
 =?Windows-1252?Q?lU96rOfmXV21dJ5L1ZZl17qXJSy+4DZM0bo+hd4lAwzs6yMFP76nBMTn?=
 =?Windows-1252?Q?q3ErUjqKx1IjYoQFg9YrzapNC7j0ZXexfmDZlA+wRN24sShNc1hvLf7u?=
 =?Windows-1252?Q?LqfyVt0GtmRlWZhVpAXM7Y3yoH2A5oeqxkPljc6dFQCTf0ge4yqlrfBf?=
 =?Windows-1252?Q?qOQFpYo6AplEn4Ra3yUSmTExSmqkRLkyTMJ5bTJRzFfUq4PFYpq/8l5L?=
 =?Windows-1252?Q?H2QX02DQXA8wKfQ4AYnyzL+RJlNhk7OORPOn0xatCOSXokUlCViIQ23Y?=
 =?Windows-1252?Q?jSLmRruhNxy8KGWb3It8J+M/kG4Lhedy/ArGdTua/s9XBtMycrEcJjEz?=
 =?Windows-1252?Q?o2tgIF8eceLvnmgUQYTOCq/LUsbzHDixCQBrSTqEa6PBB3A4vsnVmaxT?=
 =?Windows-1252?Q?BHLydalO8t2R3KldD/otcGtkvvTzf/6K0B8IBtre3dMRzgUCDnF6tXvy?=
 =?Windows-1252?Q?xEj2RVNqfPFsN6WyeyMwy70nZ11IksUO/Bk3eMYiC3P8B/HOyzUkgwmh?=
 =?Windows-1252?Q?shtcJXDiLfnbDWuGRnv4YQPYcu1fX/7MV5bVS1qDVck9n9RTDNjbr5gN?=
 =?Windows-1252?Q?7MU/uxzd7jUcsriRV6tiHTNeH0Dch+1Qwr/yCjGxco4lJ7tZoksEym4k?=
 =?Windows-1252?Q?GiVUJagtnZ2WVgPjeDTIF4tjMnjcjk41ym/g5MkP7yExSp1rXMtYS5Xc?=
 =?Windows-1252?Q?CFQntIVok19ybv9ZOL/vTgmjFf8mDv85xONfmqzp8612f4iLEvbt8mTN?=
 =?Windows-1252?Q?EFnP2fnpFZba+C9W/859X3+dSbGCku+tZpt+XEvGI35AZvXnSx0bcgzn?=
 =?Windows-1252?Q?Yzpf7gA2/Ql6A0rVBBC/dvOJy4mHZmPcBWBIcp4XqQJDInZFvqoyhJtF?=
 =?Windows-1252?Q?U8nmsNeRST3fzdhBZ0FKsenbmEVu/IgiaY9YHQ+Sol3b76rcnsVkJIkQ?=
 =?Windows-1252?Q?7n1LtmPacvYi4P+82pbdhhrWIJy/WtBJigcYl82dat/91aJ4j/rhpuFL?=
 =?Windows-1252?Q?xtsrQZRrSXrP3yee22ZDiqLCAlKVuoXWZ5JaSA/RQdjrKYvpqiRa4wI4?=
 =?Windows-1252?Q?xJgw0d3yKsrqUR6Qxjg0dOkwRTIenZM9MM/22PyHhZ50mxGWE+ISOo7m?=
 =?Windows-1252?Q?a36l8UdzfztJE7pxSHA+uYoeiYTxROYO7zgp/inORe+Oi3q0CPpdLlb4?=
 =?Windows-1252?Q?aZQAfNEsqasXlNROImPGfbaZA2YHt9z1FP7R6611ZdGSTahvVMgc89q3?=
 =?Windows-1252?Q?YxCvS9IbH8VABwfvqD3mR63mcZVsb2pqLWaiRFZ1iZb7CWkxpQs2ihrB?=
 =?Windows-1252?Q?6Y3H+yDWO7hSmr9Wrx5WQIlfU1KIpHQlh8UkK+Pi7cxpBvbzQ1Q6WbT3?=
 =?Windows-1252?Q?NWge4yJxum2skp05jmZd0I=3D?=
X-Microsoft-Antispam-Message-Info: HNYOdYt8lOuyrSk7mEjzVE6BdgrOCooesVHlhZna3BfiLba89vHV9eMbJQt861MM/L0rvelEdiazjLmlj8Ygd669MbjsQyeo3r9oCtWGYOhnFujihGeNNmI3NuTgz/c+LCbTsrsJNh3hAZhy9hDgMLgZQJlvz+TGeb2Sl0eD1VWe27vW/URoDh3DwYfm2yNXajmtZuwTBRPSy/75E7+GyFtOKzhSOfdSWPyOvyAh6fx2EXVv98WtyqJyS2aG8n0j5ni7nPxr/5HbUILq+XKfsgjxjk8CsgeaVgO5dMgxG2retAYtPSfP5yH32dZaW8YUly7Q5a2E7QrDw4Mt7tqhqwRe4IJYFFVgoUuLGKUZcKs=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:zk6hnkCy/W/C4oTlTJ93iufqMTjsTgaxlahsLwEZlzMWXdSgQ3PLp9PQiBnjvcKRDmwwY0foI+Pmn71tvI2E94wF69mWtyR1jwczxDJpgbive9loFJp4yTQdg9wMa0R4ucuzCWK6DPJu+jGh6hRd0GGucDLmhf30XNTNytFWSe5tuKPOYa9BHSZA1i0xCa2uGcygWxuHJQhqLrzo1pz80iBg9Es35N8LFmkuxFDjPRfjHgWDyYFlWmsXdDBZ8t2dGFIBIW12LeQYNYt5WpAs39TszCwy+UKSqWsL7VksA4RtTBBjpG7mfm2awbm96rgBYu1OdNMr5MrdHt0UjA9gIWbPlrmJ8VS1vKRKvVx3yjI5Jyl/Ix/QPpvFDWxlhJOYa2DIgKpcmj982mh6CSAMlMhgDecIqRut+7cfKez4accmrS+Q3OdXedM6y8RK/MFGAvjjxZbuJX2hTwweeeGX9Q==;5:SyWWdxY7E9bcO8SeBAxO1IIyz2VxDL+8bgjwkqBgVCL29y2Xlu4SCRCKAc9yIDBXdVNfYQoBy7Ovu6PJkBAlWhhCU9Nl4faFVKyH2D1f85wTigbzfD4z5RMyEm328N2+f3+Gft1zcrQwELOYaNmaI3U1BKMevYnMyGDBNYyn8UE=;24:mbK83gNZaw6iwcGKp/id1M+k+VmKnsDu2tt4hESIErniaWMY0l57Mw4uESvQDsQhVHmbz/xaAdW/bbFoLa/qSd4PdU3ZMnPg4jxAdLBqlY0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;7:WN1PcvWxJXFfYCyuLO6qBAOd6Wxc8mYnyLtFibWjpfZqX/Hz4+Cyvu4jEyVPjrhhllKKEyN1bJ1fiDcvZtI4vfaFAc91lwXjATURPcL884E+Cs/NEMRQYhTRqA9rEYgQ8XGfO3uDN081LQJPiwT44Op7mCsXBVojR28AMdHIpVyE3wPTc6MjzFBACsAcsAAlwHHDmGf9DNjOAGVoNnaWv+9ADFlYhLitkFQpAdgnw2HvXu9fRlm55SsjTN36HCb9;20:l7KmzZxLJakIiCBUEAXiVqXfF8YTgKqm+jfB1HN5U7s8Di2SLxK3h+KXmlWahAuas1m/ovdvQBg0bfFcXRHepqCyeSZF07gndcmWMsATHHpm+DMCmDjRPXdGot8RQOxVM4UYBOuhPHO4n7Qnn7CgYnRZ5GBEtiASUlyX86vniiDH6/BJCFVIMkY3pPr1otDgVDBqqdvvUh6LM+h9oYxMAf8/Oljsunzgrd4M0JP8m6E1HBwsq3wobZnGLdw9jJFZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 05:27:05.0846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94094dc-0448-48f4-f0eb-08d5f05cef2f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2018 5:48 PM, Mark Brown wrote:
> On Fri, Jul 20, 2018 at 02:38:11PM +0800, Akshu Agrawal wrote:
> 
>>  static int cz_probe(struct platform_device *pdev)
>>  {
>>  	int ret;
>>  	struct snd_soc_card *card;
>>  	struct acp_platform_info *machine;
>> +	static bool regulators_registered;
>> +
>> +	if (!regulators_registered) {
>> +		ret = platform_device_register(&acp_da7219_regulator);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "Failed to register regulator: %d\n",
>> +				ret);
>> +			return ret;
>> +		}
>> +		regulators_registered = true;
>> +	}
> 
> You should be unregistering the regulator in your remove function, not
> doing this hack here.  I'd also expect to see the card made the parent
> of the device that gets registered.
> 

This approach shows inconsistencies and in some boot cycles da7219 fails
to get regulator. Form the logs (below) it shows time gap between the
time we call “platform_device_register(&acp_da7219_regulator);” and when
the regulator actually gets registered.

[   12.594237] regulator registered
**print after calling “platform_device_register(&acp_da7219_regulator);”
...
[   13.583689] da7219 i2c-DLGS7219:00: i2c-DLGS7219:00 supply VDD not
found, using dummy regulator
[   13.593818] da7219 i2c-DLGS7219:00: i2c-DLGS7219:00 supply VDDMIC not
found, using dummy regulator
[   13.603242] da7219 i2c-DLGS7219:00: i2c-DLGS7219:00 supply VDDIO not
found, using dummy regulator
[   13.612626] da7219 i2c-DLGS7219:00: Invalid VDDIO voltage
**Above DA7219 gets probed and does not find the regulator**
...
[   13.750894] reg_fixed_voltage_probe: Supply -> reg-fixed-1.8V
[   13.766746] reg-fixed-1.8V supplying 1800000uV
**Regulator actually gets registered**

Alternate and consistent approach to this is pushed by Daniel here:
https://patchwork.kernel.org/patch/10539485/

Thanks,
Akshu

