Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1301DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7092064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="I0GgZ3XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7092064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbeJAS0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:26:43 -0400
Received: from mail-eopbgr30120.outbound.protection.outlook.com ([40.107.3.120]:54880
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729218AbeJAS0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61oQ8fEpvJKfpyrfMCGxuxza11GFa8RCn8kDRO1wS1Y=;
 b=I0GgZ3XEnc9s1Xo2PhwesCWcR61sW6zaLl4rXjC+jtcsm59UfhqHkal5gNXpcnDyhBlpccgBUM3szNsc52ADvOWOj8x4Kp9R2noqBSJuRFwhSMLFEM9tStCIXAro0VKlCYnNwBflA6iJqfpJW/94yPr7oMpKha1neuOM2pANCf0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Mon, 1 Oct
 2018 11:49:14 +0000
Subject: Re: [PATCH RESEND] i2c: mux: pca954x: simplify code to reach the
 adapter
To:     Luca Ceresoli <lucaceresoli77@gmail.com>, linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>
References: <20180926083534.21999-1-lucaceresoli77@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <14ba57eb-0647-5dca-8f84-eaa27fd0af4a@axentia.se>
Date:   Mon, 1 Oct 2018 13:49:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926083534.21999-1-lucaceresoli77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0158.eurprd05.prod.outlook.com
 (2603:10a6:7:28::45) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f1d6c3f-51d4-4873-bd7f-08d62793e984
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:+xw4MchpCwplvNy3H1P9I6DIbm4AgfpXXneTmoz+A2e94o2l0Dxud+N5rr1OD/6owzdRcIDBJMZ+rDAYCPkPgrv3MfSruvp/P6tupbAzwSsfjiv0Rs5v7ceuanDSoy1OhwzB+710aGrQQMFZdSJl29s9AZQXNgNrQCiGgcNPtNOW1eE+Q62DH2kw4W2nzs0B7PuoLZmoViiBsP3LaDeYQSJGOk9VuoIq3QwxPsJKPK0xxXKIVlGk2KsLCFW6WmtW;25:fq8s1yezULuVpiL6IJkarlNF06CYf2acV/gPRhASIFh1kTBhVbIdlk8EB/IMABHQuuO0S5DpggYZoIk50GKsZOp0OGlwNApCo5Tf8G4qkEsJzA+dpld9lnbbrNQd/+9Djk0ZScAjLTvRXeXvnBkgDXVD2v+uTlB75WbG108Om48JcfFF2mP0tPf8j9GKW5M99XeaEc88DlAZArpbBhUlgiEOg0RBj2e+Kb++6iLWrfvnR/edWFw3okwE1hiP8nMGlAEht3DalkZR31Rcf0c4AFyj5jtF5qflyA0Drvryjsk1F82Bghiyzw5IJeolae4vLWPNu3MA0B94FWxtJs+srg==;31:UtMOR7BaAJFgalSlMNTYIulDpKxFtCGp/uUmfg6HsPad+gtMd/lKD2Oemn3Sr0dPwfHJgx1n74kbDjbtUAXoCoqzfvsywKz6KdBIFu3K0wyDqPHq+QGLJhReWgUGLOtFpraZYvNEFiLKswr5ZrJR10jbq2fUcNQea/poJOR9SVM1divZ2GTDmfQaSmfQY9O4HaGelPabEci9aKgZRPDUK64LMLmHMlTYMEX1QH8GnS8=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2464399222FEAC133C497B71BCEF0@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:m77q06arzkRho3ocC/jMIj5vRSOxxETS56B6leTyuOID3gBFAL0mTgokz20E6mPc1VSv7JT5TBfKxfdlP0OuzhhTmcVyauvPMETMsaApKrDywNjh5Yx+MGVk4vT3MS8K5LYFprtA98YbM6sh8lBFHZTYKASupkZXLy7HehUvdO3gZNRo5EWk7defBbUQmrLGqsEPl63L+r7hlXuf7SpKZJcKWJ5d9nN1HzNFxglyll9RNv0uC3ItDj3hxRtgP3MRfcVhzeFwCz57vBf0s5FG7Q==
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(136003)(39830400003)(396003)(376002)(199004)(189003)(508600001)(53546011)(31686004)(53936002)(106356001)(230700001)(105586002)(68736007)(97736004)(6246003)(4326008)(74482002)(34290500001)(316002)(3260700006)(25786009)(7736002)(58126008)(6666003)(39060400002)(117156002)(86362001)(5660300001)(65826007)(486006)(64126003)(76176011)(305945005)(81166006)(386003)(81156014)(16576012)(2616005)(8676002)(476003)(36756003)(52116002)(11346002)(36916002)(23676004)(52146003)(2486003)(446003)(77096007)(31696002)(6116002)(14444005)(8936002)(956004)(3846002)(186003)(65806001)(65956001)(16526019)(66066001)(50466002)(6486002)(2906002)(47776003)(26005)(229853002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjQ7MjM6OWxxMTdHYWZ2OVRMR2FzSUdaVVZybkZX?=
 =?utf-8?B?TlRyV01QdlVTMEFKR2RmR1Q5b0k5M3hCL3ZmbnVvQzRGalhNdGN5L0ZnSTU0?=
 =?utf-8?B?cUFuUEtzbmgxT3NKVyt6NHdIdW9zU2VSbXY5NUtmTCtxS05GcDlGalJ1aEpa?=
 =?utf-8?B?b1BWdVNLMG5iUmJsVTAvUGM5bFEyR0pFV0Z0ejFHQ0xURHVaQ1R1dGdpbS9N?=
 =?utf-8?B?SDdKbytUZnp5VDJkSTNPZ2tTblJEWG9EelpieGtiS1dIbGVzaHoxQzhNdmhZ?=
 =?utf-8?B?am8wcnN0cUIxZCtFdldFRmZqdUtDK1NyL05RSzlUdlNyVUVnOFBJODdwQUR0?=
 =?utf-8?B?ZldIT0NFS3Bzd2pYaC9WcUdMNWhKVDJ5YVVLcUZQWXZYT0s4R2RSVlJyck1m?=
 =?utf-8?B?c0dXN0FwZ3g4UDlLQTJocHBJTnZ1dkVqVVl5R2xsT01RK21MR1ZwSTZ4cTBO?=
 =?utf-8?B?ZWR4Tkw0V0d6dHhGeWc5L09JS0k3K0RKYnA2YUV0TmVBcGphdlB0dVNCdVM1?=
 =?utf-8?B?S1llVis4d3p5L1lYa0xJTzN1dUx0MHlRNkNJRUd5WnYwQzRNcEhGZWM1YmxL?=
 =?utf-8?B?YytGZFhTS2dnZVk1S2xkdnFuVjZyYWNNdU1lZ04wZHN5RE9qeHVMVUtXcC9G?=
 =?utf-8?B?WGRrMjlCUkphWmhZYkNZN05HdUFJMXdTNkQ3cVpkNDQ1K0p3QXpKRkNhZG94?=
 =?utf-8?B?aUFzRFZKcHJNbWVPblVBQnZkck1oNXg0cGhVTXB2VTJWdEdhaVNZamg0VzVE?=
 =?utf-8?B?eWVqQUM2djlmRnQxem14Q2dzdjVRWFQrSU5XVXpQVCt1bURuL1AycXd4OS9G?=
 =?utf-8?B?eklKdWRpVkgrdENwNnp1VlAvUkNLeUovRkhpTUpJNThPYVY4VEd6MXZ4NExO?=
 =?utf-8?B?cC8zOWlKYk9zWVJBUFJkRFE5bHk5S1dCMC9RU0VKOUpLa2dNOWNpSjZoRnBt?=
 =?utf-8?B?R1AreHNsSTlXTXd4RzZ2RDJzRHlSdlhGTFhxMTg1Nm03bWFOS3lQQit2WVhi?=
 =?utf-8?B?bC9ybUFIUFQwUXUvWWIwKzlDZk5qS0VvNTh5NURyNVVHTnNPUDZOS3JQVENZ?=
 =?utf-8?B?N3JrOHIvQ3BUOVd5WXpacGVnL0k4TE4yak9RUTRWdmRsaVRaVVpKdFovUVVw?=
 =?utf-8?B?ZUpuTm9JZFJ3YnIrSkdpVjdHMmZOTlJNY1ZZRnBKdk5XbnhieGxtemIrTzU0?=
 =?utf-8?B?T1F2dkVrRk0vbGJLUzYyV3dHOGJUWW9ldDJMZ0tRTmg0R2hJVjB0OStaUU1i?=
 =?utf-8?B?cG9QTmxFOGRMWXBTdmcrdTRxK2JnNHFYbEs0QmJCSmdaTkExYlRRa2p0WFl5?=
 =?utf-8?B?TnFvZlRyR3JXdDZaNzczNmlOK1NmdVFzaFpYMHhGYU8yQ2RBV1dlaGE1RTdn?=
 =?utf-8?B?RnNXb0F6TWpHZWJtQ2FPZnJvME5rdGpiRTBBeS9IM1dZRzJBTGJ2N1ZmNEFN?=
 =?utf-8?B?Z0RFdUF4citkUEpwUXFYWjFwU0ZnMFJMQWNPZkZ1MHJTR1h3cVloSlJDa3Zh?=
 =?utf-8?B?SUxwMkNINlhvRytOeDhrTkNrcVByRFVUNXdTT0tzK3RjSkhXSnh1eDVlUTRQ?=
 =?utf-8?B?T0dMbUQxTS9BOFkyL0dLMnNmNnd5RU1FZ1dsOHEyRzBDTlQ1dmtKbXJlM2lM?=
 =?utf-8?B?MDZ1NnMxNDdRWmRqOUNVKzhteHVmbGt1TDV3SnJPdUhaZnJSU0JFcTZBa3pW?=
 =?utf-8?B?c1M3eFowa282T0NtNTFOdzBTRnJrYW40ZWtRL1p5cW85Si9oRjZKMXJBMlFo?=
 =?utf-8?B?RjNQSmI2SHBIcXVjSUQvNFpHbEgzd0ZnakE4ZW8yWlFOWTVsMzZadURheWd3?=
 =?utf-8?B?Sk9KM3RuS05BaUdlK1o0RmVVM01ZQ1hEOTVyMTE2MVdSbkZPWUo2MUwydDIz?=
 =?utf-8?B?bVJ1VURTOVZZcVpTTENUQk13VEhueE5sa3ltQTFZUFlOUVFjMFdjdTUrclNp?=
 =?utf-8?B?QzJ6cXc5ck5Oa0h3cXg3QkJmL1hpb1RKYkFKS3BtOEJpTkNQcjJwbGdXOFM0?=
 =?utf-8?B?dTVDNS9STS9BZ25ZbWs2ZnViUmFNbGJEUVkvZHh4UHM3eTFtTENqTUJpRnNh?=
 =?utf-8?B?VFl0VTQ0UVZHdGx3SXAveWFtTVZkZGI2TXBFcG9Ra2ZEckFRWDFvNlM0RU11?=
 =?utf-8?Q?m1urE/p54bcdGPaSgZObPbFyY=3D?=
X-Microsoft-Antispam-Message-Info: isDyjEzP/Nz6H1r25DvVlUfvQ9mNWvIeip3LwhZjE0LgczsixyMQAXDN2r+aOtomoskMaIVV2x9uMNExYP1SRme41UapGAU8VlInST+dfGvSnvTAL6A/V/4nI7ZE9m+4y8BISx/v7jPF5ABfCT93BT62ibRcsQPh5059s6lfXsv1bKRvjrYZn8j2MvDKlcct3XVta+qIa763WnMaxs6HLbOFTJu5gubnqitKqFqyeixS1uhcH6UHa4OTst2l74GMjERVuUXNM8D/nzW/XhtusqFg8x9B8AvTitMPEH8P1AmatdRqvbEQ9v0n8eMkgGZ42doOUmPrAxrhBBEdCuwgqT3IlPdi6YO7y3lVS0XpHuY=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:Z8FAeougPY9UEcNpZJA1y5x6jIOpazlgqd63ZsoVenVli04fljBN+9eymS3yQH+eSdv3paeQleiiI7OU5jPKS9WNK3UkhEAPDHQJE18POqdpUVS3w2IVkJ1vkKUZ7XHA7aXiBlzNezhlgw/gxWk3sELQtkoSVrR3X5Rf7bDy54Rx5hZTY7SvkZQv2fFL6EHCHnhrqyy5LyHt85xs8HbuSlkG0ywwt/JMv3Swx6qkmh3XGzgM39zqQUZ7ZaQzuOGx8yd3QCCGU5dxWyc0noqSK6rcU0r7QeN7FjNE3Z/BV9dxTdg0CVRQX8bqoj4enBvkqcFbTSwA6dLW+dHTHOm8UafJeE+m6N3qUBRphLxzgOXfQN1goi/5jnj6ngCYGz9rMk1rT6w3+RXlz68ifPlIlHa0CN+5Jf1ZPJwutNUn8nmngews3u8+3HLPYMo5TrjI6iyWFjqhItOQAc0XKDX47Q==;5:R+GQ/bxZ4W0xqdvjqaSWkxSMUswb1R+UmLdiZF2fATKWNGNU7Ra5gLr47sU5VSqzGox1/iNnFAA23ctRjgUZMH6CLRkfCFpb8hjZ0lvB4HgZ4oCGQao4Tbn53h83jXQPENa4WWDXdBcE7crGsoBFEzOIYkIUX0blWMv7u+KWyYY=;7:D8psVrTSQ/cx+HSoeww4DhYaLwPJlIf2IwaZ9gs7grcxc3esRx4blpSFriKhLDHQ677IDe71sP5QIm6hncD1WTIxtTLx9rDvc4FoLLLdpR/pfG/Nqd4tmSVPI1Dttg/T1MAKPtWZl4jBkd78YKEr5GQ+aP0unVWvDqkLQaXk8tbLTW08uG2LQKsuEV1cIkJBNWCIE+tXeTUw/RuIy05+WuLKogjyVZ9z1C0YecJ0VL0v/JAPRPev0fvYbBUaNPzp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 11:49:14.7063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1d6c3f-51d4-4873-bd7f-08d62793e984
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-26 10:35, Luca Ceresoli wrote:
> From: Luca Ceresoli <luca@lucaceresoli.net>
> 
> struct i2c_client has a direct pointer to the adapter, no need to dig
> it out of the struct device tree.

Right, looks sane, but can you please also do the same thing for the
ltc4306 and mlxcpld drivers which have the same pattern?

Cheers,
Peter

> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
> 
> Sorry for the RESEND noise, but my provider and vger are not
> interacting (again). I'll solve the issue at its root ASAP, but in the
> meanwhile I'm sending from a different account.
> 
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 24bd9275fde5..bfabf985e830 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -347,7 +347,7 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
>  static int pca954x_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> -	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
> +	struct i2c_adapter *adap = client->adapter;
>  	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
>  	struct device *dev = &client->dev;
>  	struct device_node *np = dev->of_node;
> 

