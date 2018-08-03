Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAD2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8821D21711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Abfpk+Ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8821D21711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeHCGoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 02:44:32 -0400
Received: from mail-by2nam01on0076.outbound.protection.outlook.com ([104.47.34.76]:7136
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbeHCGob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 02:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddv4kYpU89ob+XT48FriOjj31K912O5lo13iBzmfVdM=;
 b=Abfpk+Ewf0Z0fUdKcWx1os8ppg0tzEnyVzvnLM3qmqdzkxcSQLHWjO7+vcz+sMMo08fvPaY9MRi2Keu4Iy6scb9X+leD1CneEXQRBSEEzDc9s/aYsg3U8qd1DMVV2OKvoruFAD6D4zO4gtyauDAEU6DwF9x+XteQ+lNpfrXe+3U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from [10.167.103.249] (111.93.218.67) by
 SN6PR07MB4928.namprd07.prod.outlook.com (2603:10b6:805:a5::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 04:49:59 +0000
Subject: Re: Re: [PATCH] i2c: xlp9xx: Fix case where SSIF read transaction
 completes early
To:     Wolfram Sang <wsa@the-dreams.de>,
        George Cherian <george.cherian@cavium.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        jglauber@cavium.com
References: <1532323119-11085-1-git-send-email-george.cherian@cavium.com>
 <20180731210513.izqbzpvvqq5lq4uh@ninjato>
From:   George Cherian <gcherian@caviumnetworks.com>
Message-ID: <77928aed-a9c4-48af-6766-693a142568eb@caviumnetworks.com>
Date:   Fri, 3 Aug 2018 10:19:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180731210513.izqbzpvvqq5lq4uh@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0101.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::17)
 To SN6PR07MB4928.namprd07.prod.outlook.com (2603:10b6:805:a5::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c2e9447-212a-4bfc-7632-08d5f8fc9248
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4928;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;3:cOvfBwBMkNitq2cgAwtznhEP0r9aZw7lBI8Cw5hRGXtx7CC5Gkb+j994Y4ypSH7vkjxPOMUc+5HMnWTDFKxWmrqprQYN1M4zjL0OUNWrjurrRYzLst0TN0aHqrVhAgSen8/gmXfrPl86U1jUzEENdch0/Xg1y+7rpyWlarTEf1Sw9P4A0xdZOEjEEOCcMwQ36BuaBL3KUt3wDKXdKOGyoCOmMq76gbvqQ8t7EL5PNm0SWIg2ti7iIx+UbPD1OG60;25:1bllHNYIMUqzgs31GA9OWyttgWKmMcF037Lt8VTYqyGnx6ql5lvSCTtSqK1LDvGUoANscrMdIYSDRJSKV+Zfv8XLJBWMTKgvwt7Cs5/F0FylygoIf5qg+Ab8GfDcKS4WgMfixJPyih4urIeog24XGCJ4thO2e4sv63M0ZPyT1hV1BHVsz76llaSvcjPPS7415W+O784TiGnyiPFa7O5qMKMNNAOx4hPQHCIJVHYshOmVAyP6IB7g8fAvSVzuAy4ipeqJUIOYVeY9uyfoP0c6w8t3GGjXB8HFXPGyAplqPKqeCEGiZ6w2vGIs3yv9sHGV8GmC6oUW8Mto45Cjv3Ungw==;31:skU/br2+OFZlY3IuIksO+h4U8wRybN40FGhCH01diaoHCxMRsFCh68KbJNn7jeIoqtfEqVh7mVY6XlHu9P6xXWH6yxQ+VreLtt/lGYTMAjN9BH5Tpsln39s3aAVhCIU1u6Bg0MG1kM2CrWsvaKODgFeSg0QRDeGQ1j0aJUULiZyBf7uvWGkOkGU91kdsZoiNFfbbBnIVV+WhjfsX//IL39p1SWKKO0mRB/YlPkKlaj4=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4928:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;20:U3n3uFMz6YbkHkDgHWtqsO7VJAKq+14nOcnm+VnjFzexmYW/OpFL1R3JEet+D4tqX8BPiYZsX9Vtpx7/RWCB5G31gqBw7B/OYEP9X7Pdps/2Jn54RjsqEPKDIDlZFx0gWklvi/fvsTeaACDBvX0kWEE4LyHnl/IRdQgH7YiA+6BWn7Oypt3pHLxm5FOzlv3NuE/k4/Z7jO+gtfSeFHtWExaUTvGAPBJa1eVk1Nkdg7ta0UD50L9nEBpWEbOwmvyEkxlj4sM7ncQYkNhN72wMoUo5gKUmsTqm0Wy5MFIcNLlbLdzDkcDuOJB97lSftp5r+DWcN2DJdIkmm95f1X8BEPTNLQCECg60VEV/MD+cRA0e56JwytiwbLNBNoiO9Z4HzxqK/IXXZggyvA0j9QoqDliC5TToScvAkpbXTmqvQctQ/9PEGa15QHFpH91h9ZHyhBCmjckH/aKobbwiaL/0awgMQdu3o3o41pbvD2PpERj5gLjn45wLMu02/QiSdtjPLpe65aFQFqjigWs2zz0qPbRUkQuHu3N8vghxqIBwGfkFGTJUiHzz8/S8bXiTA5rjWhbeGFBcM0h2ljYJaEoXSMGPz82q9krnqdYDp7nsLbU=;4:lujsfJdZ3qU/2loVSTM0qIQZOUIIN+FGnPSXUPnZrLRqin3ihA9L8frZvYc3k3op7qInXMaYyxeI4F3gUDtvE08WK9ZEQQgfQXmHtNhBasu3FsdA5mIu2M/D2jA35NmtE2DW1oNt2/OKqTa5QnJufE2ZyV12AmbtU7hv2aPo7F/cP7c16v9Ms09ueQLMU/d11soxDbfjEuqGnomwIEiHayG8vH5ooxaOMCQRTpoPVq0eIVAhjLJmtk7ppk1C7YXGh/I2T4fut8MgRh4ai9rctg==
X-Microsoft-Antispam-PRVS: <SN6PR07MB49284AEAFFDF744288413CDBF9230@SN6PR07MB4928.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4928;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4928;
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(136003)(346002)(39860400002)(396003)(54094003)(51914003)(199004)(189003)(65826007)(23746002)(53546011)(50466002)(6246003)(14444005)(486006)(5009440100003)(230700001)(3846002)(64126003)(6116002)(6486002)(229853002)(25786009)(2906002)(53936002)(42882007)(11346002)(52116002)(446003)(76176011)(476003)(26005)(16526019)(97736004)(5660300001)(8936002)(956004)(77096007)(2616005)(386003)(110136005)(7736002)(58126008)(65806001)(65956001)(47776003)(105586002)(16576012)(67846002)(6666003)(316002)(305945005)(478600001)(66066001)(106356001)(81166006)(8676002)(81156014)(72206003)(4326008)(107886003)(68736007)(31686004)(31696002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4928;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN6PR07MB4928;23:WhnbV1WkVgYqTcG81ORj6O258BsYhZlPd0obD?=
 =?Windows-1252?Q?wCxjhSpDh/97uZpsHngyAVGsK+LvoQSAzWH5UgHBucvyat5O0FxwgHbd?=
 =?Windows-1252?Q?4YQwv14xvDOyOLyfAzRLMQwRWjoc1uzmKC5FTgtfxc+lnmiFAOtLXlb5?=
 =?Windows-1252?Q?wMpVlwiu2iDxWic7FAVOhLEA68B+dRa7HEEGGPwwc5b/0GRDXt/M6aoF?=
 =?Windows-1252?Q?ACndZW4518N+QTqVquosWeVMAQAy2MCusBI+2Jftl7iveFgmBFLUHCQ/?=
 =?Windows-1252?Q?xPxNrriFaNJEj0+W12ST1eGPV8KBy2paWRkZ4zTxn5RNzZv4+NNHDy0V?=
 =?Windows-1252?Q?8dDom7hu7Jp97o6HNrJlYbB4OeKgwSIRikYl0zSOgfyo46lCa8aq02a4?=
 =?Windows-1252?Q?Oq5fFFXM8nX1IY11L30fnynYxpxg3T0aeGf1W4Y1NLMfGWWulcS0cG/B?=
 =?Windows-1252?Q?VPefsDiIGN4S5FZWsxa03Au/w+S67gZSWH7RW3hO651xdLCMEPDOl09T?=
 =?Windows-1252?Q?jWlOvGWlRBkRUafuU0n77OEYah141XbnZBK04xbfeN6gPIUZegi2xiY0?=
 =?Windows-1252?Q?6TNmtyBw7Eor01oLXv9r3HtQe08gmrl3V7tPNlSrg8+M800XQSXOksFY?=
 =?Windows-1252?Q?dQ+USU38E6tSjIT/8jkbl235HJ37D4cKt6ndJtJWF07DaZlCpsmdQLNb?=
 =?Windows-1252?Q?fA/FDHEt01gZSDJ3SPqchR+tPp6aHdj77GR+r/diboTJuP95l5uvqls0?=
 =?Windows-1252?Q?fZUeoBiDgRjvlsoje8znJ+klpkt/EcxDdc0AfRQy9tgu4wdmbkKX0wrE?=
 =?Windows-1252?Q?p2qZdXOGJ3IYe2A9wskzCztUmLFaNbkoS0y7aOzTd0UuD1HGgwODQZbk?=
 =?Windows-1252?Q?O/S99aJyYwxrwWXTg+PnJNfaaBJJ+D3XW26Nz3zigCER2Y2f96ufK0MO?=
 =?Windows-1252?Q?C4c9zD4/D8dV275gKHUXPBoDuvTG0RZcQ+8/qd3pFCvgiKgVgxHARmsg?=
 =?Windows-1252?Q?ce5cVXY5Bxec01+QA4UeaBrSJY/plLsgElJoN9gUm/hEGKXp2z6ZjJUq?=
 =?Windows-1252?Q?opgBrpdLbc1xzEmatyQCy5N3kg4tMjMCxQjZapwZdlRvkZ5YzIDF9/as?=
 =?Windows-1252?Q?0Jx/PoyLvfUYcyADrlNXkR1XIewCXajfuxdy2f0KNJnyrRSG0MceU98+?=
 =?Windows-1252?Q?79mcovxUWVuZEywtdcCS9DdTOoklXDd2fy+e+JW+QSM3LCfmGdBuTIru?=
 =?Windows-1252?Q?wO54O7bzoQ2hx/HqWW5qHXHBqjoy0XuSwV5er6XdfeU5pFDpTmvI3j3S?=
 =?Windows-1252?Q?DW9QB9yS7vrW/FINFXHO7izExDZB0kXfoufzSpZ/GGYx2rxKlYqvnSDp?=
 =?Windows-1252?Q?3B/qiIeYSZ0aBWCQxOrl9x0UVelGjcOanRnRUHjZ/yvcI/LYktU5ayoT?=
 =?Windows-1252?Q?gPmDR5Jf/jjCzQCmFRrNfQkdyzUezzqBsAQLVD+LObQvIQUBposCMoNo?=
 =?Windows-1252?Q?+fgebgUIxqL+nV/+K/VWStCzdwarcTWZQ+/S7osxJ676uatKoDSejc4l?=
 =?Windows-1252?Q?5sZOA+mRDOR8nMm8DdWZ7Hp0EKu0C/bT3Gz+TO3jnTbTKl7d8gYlS9+a?=
 =?Windows-1252?Q?m/alrISPYipnvz1A6PN3Ds=3D?=
X-Microsoft-Antispam-Message-Info: u+QX/0+bxsSqwJmYFWXS9gPZyPJWybjpmBBwJ0XnFzHY/yarznzxHqB+mLV/13aH50jkbgh1H5HbS1QXst23fiOJu8ZageHR6EOcYwM3849GPQRun7+NOCzG9cz5I8ovIk7LSrPIBp9cr8c8QsSzpJgzNfoxsJRbUC+pThYjSLZVClxPAKbYvD9sDg0a2dJHDSTvj5festbJtj/PRfMjlnZ/tr66QM67KrNpJ/EKNYQUU0PkfuyB0l8sidnNfttFIAQUAyaaO8LeXGblI5B/TMISWTniV5gS7sD4BZI1gmi9L7+KIpsU9LySVRYvH2o/Fxb3CaxnOJNpT8vhrHTlswGjfZ+SuLvadUlXS9Cctls=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;6:G+XR4JmHZNPsZ6zCcQ0uMkQD7PdcfDs3iKVTmNdrVqlNPF6pHeGeHkzAhBy/n3FSfha7aKMGMEhKcFHx4oJF3/GQZ3a/RpcpX9/BoA0Mcg+gKGMf35Glg0OgrdtkMErrDzmDE5Gcwwix9jBB+iZ4/MdxGSLj3E0ICjAISOHesphvd++SajcMECzwxWsQ4tmfcMtakoGVCaDc4uytZm0ZvFzqh/Io7BhpDWAGUa8UhGMUc2LFvl8pzucNhWtMMPpaUvTtk+jEIzfUK9AP1vQTdf+fafzgydcBANwVmsA+4UDDEh4BtHhrxgzrisx07txVNAqwCKY+M5oyGkx7NNEx2FSF0qnauP4n/GhPvbLXYNWNWJ7JPQ6pLTSv+B8mFnD7HtqYXhm20QdyWHiukUnqOZCG/J0B9HvvszAPyK0GsmacaD+znTRxsZ1WZ9czaatBjlAEow7K3c2Zfsoy4rEW+w==;5:Zp9YXHh+YcuDsGejadm5Qtl4RQ7pHhQBZI6ragNRs9jJInLmrZKFLBQP6/MqWnywAX6tlA1i8Lq1eSJpnwTPfZn2G4XDqGDvZEyOMKYAuH2elUPtlwGA8mNBoO+bp58oxrru3O4kf50+kC2wFum9iZ8v3zvDtjDpHChjDRvxRvk=;7:UZczNHyNTDQbuynrHiwi1J+4BqcVhLKezpnAUqahZJqXTQzYXbk7UZVeIc9/OObDSCDpREYvgvOHmwWNzgE0zKj4Pu2fw7Rp3HD0yq0wV5mjbvMkCSqu794XsVOr3aQOR/bRCuBURTYS8NCpAKbgsroCOl+5BQBNQe3GOKZ2ilkI/eyUYAj47EXBJbYfWT2BObrZxu0hoDyr1kmfsGDjSQYAX/BKc1RoLPHYDwpFYpn0wazC9/bBd088xP3aAr4i
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 04:49:59.1838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2e9447-212a-4bfc-7632-08d5f8fc9248
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfran,

Thanks for the review.

I will update the patch with a small comment section above
len --;
so that there is no confusion.

On 08/01/2018 02:35 AM, Wolfram Sang wrote:
>> --- a/drivers/i2c/busses/i2c-xlp9xx.c
>> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
>> @@ -191,28 +191,30 @@ static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
>>   	if (priv->len_recv) {
>>   		/* read length byte */
>>   		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
>> +		len--;
> 
> I don't know the HW and assume the above line is correct because of
> merging two interrupts into one. However, the line looks a bit stray,
> and I wonder if we shouldn't add a comment somewhere explaining the
> situation similar to the second paragraph of the commit message?
> 

Regards,
-George
