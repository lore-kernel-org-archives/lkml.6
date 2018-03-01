Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965347AbeCAAfR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:35:17 -0500
Received: from mail-dm3nam03on0070.outbound.protection.outlook.com ([104.47.41.70]:24992
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965280AbeCAAfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:35:14 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH 3/3] crypto: ccp - protect RSA implementation from too
 large input data
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4af6c02f-db3f-3d82-9685-367913c684ff@maciej.szmigiero.name>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <49db7800-b052-79e8-8d8d-24ddc6382e48@amd.com>
Date: Wed, 28 Feb 2018 18:35:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4af6c02f-db3f-3d82-9685-367913c684ff@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM3PR12CA0075.namprd12.prod.outlook.com (10.161.151.147) To
 BY2PR12MB0693.namprd12.prod.outlook.com (10.163.113.158)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc08457c-9ca4-40ca-f80b-08d57f0c4ab7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BY2PR12MB0693;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;3:mImU/D0XkBjq1xHQp0RLLCs/aWna2VRyqsQmE2AWgpa9KMOxmOP1nZPrtWEv7TRwfHOtVYq85RGcek6wAfZtxVUWMChr51tM5BzQ5s/nTYUrVMglO1s+4oWzH52nmpby6lg2jUCyb5ljd458JP6vXm566fKdMUJ/3w9kQicxRDXgUzRUJJmTPp2Eff28Dpz3JR1GTVJFY6d9jSpT91XrEmSCx03qZUgJ2GXLw6KCEHPF1Nqt7TvMOri5WaPqkYHc;25:fBVO7BL9v/XoZTki8HzaBt9yG9GVwzKpkHTfNqJJgwIUCBAG7d0flTWiAnHMnzqeUZ8PXwIAkAwzG7y75FiBD5yZTTMz+Omvva4AdfSMawGOnxj8VH4ZN1IPsPoUCNyvc2fYEk8n/QTEMTossD1pr2myi/A3XrpbekyjAg/isE7WrdUcuDPGAW9Q2wNOrV18pBTrYcQQVNjfsaD2H0u3Tt4K3yhmYMzdHqQ3wZvwtiCSOFMB+6H7CkbtzFtyJhOZaSnyKc7xKGniL/5MzDkoE3+K/NA9psWu2GhXtE6gK47vyhDVzAmwQvgvqoxiSIezE/FysZr/P8uQmSeQU/+Z4w==;31:TyGVUcOlFNllOPw2MFGcpViMm6bU1//dWQRpdsqFr6DdRuZJkVnEn8jjXnt2O9K5cYgqhrMeoDuVNrwBJDZo9NHYzWRWodIEgVcf7kXpEMRIaCtfTyK25BmQCJOeh1J3sd3J23k5dDE9SgfGFs5evGzOP8lnGMMDrQxO1VxeETrx4Go8YSCi5xergoRJ7QfW42MNOQp/U8IFb6rET6jGMvLL2cvcZViM8N8TisQz78U=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0693:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:hbepVuzM+wgzUS9i9PNrSMuGyFg3GQjd3a4W66+6c/HSYAtSRjMW+myp1OCp5zhmm66xjZj0o8VaTUbcxsE7t90O1hlYNsrJBTZvOhtT4/csuLzXCq6Z7YeHwjtgPbeQ3IratN8PbvJ65j6yedheCGg+djsizfGK26nHrJGnVQmdYv7z/xg+oQouCk5bWrvMOYJhYgIip1mhryAOeUtmAF6pyQB4XJOccvJhQHJJcZYKtkxsa8OZRDH4TnrOMFsv4o+EiXzGnMmxQOXQ24IX8oALJcvh1qUIJf9SDyQS8WGPLzS2FeeiiahDDhFLfhHBSIGID/LTnzpbzGsT3pOE/+MjiS44zrZi4gH2AHE7Zam0RbyfNRSiiWnV7IxPJDY2AcBTDadkuPXXw4oD7EMA9k8KYn7zRoAgPD3DW2OgNyfobB9eDeN9kG1R2zI7rBuoRI+4CAGeqnA5sva3sJPssa6dD+Xu3z9ddO9LVTMeZ4QV2BQCS3kfuV7hFwgZXBhs;4:JVXvERNSfGUUxF6HGk2rRPy1lxpeeDwXNB20fU0XMQRYp5WJKysNfvWDPfSHdxshJz2DoerOcSLw3iD5XWPep8vMvhD9eJVanEsnpzVCi9zzqfDlqeWUMMVs+IC/85KwRWQGvrmc/nmc7x9iooaGiRp0Y/mgwOidnIerXTZ8+3/uRJG/Q/mA/k3XHrHuXXVg/oqdRhl4lQWH1zQRCFScOuq9EgBO6j9Mimdk6m+hdsjIlMmjMTd8paV0nLfFbujIbvDeUUZCWDBwG1Sqd2xKTQ==
X-Microsoft-Antispam-PRVS: <BY2PR12MB069373A49FA27B6E317FF705FDC60@BY2PR12MB0693.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR12MB0693;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0693;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(105586002)(81166006)(6116002)(36756003)(25786009)(97736004)(59450400001)(53546011)(64126003)(65956001)(86362001)(66066001)(386003)(65806001)(4326008)(76176011)(106356001)(31696002)(3846002)(52396003)(72206003)(52116002)(31686004)(6246003)(53936002)(1250700005)(81156014)(8676002)(478600001)(67846002)(6486002)(90366009)(54906003)(58126008)(110136005)(2950100002)(16576012)(8936002)(6666003)(305945005)(68736007)(2906002)(230700001)(16526019)(186003)(50466002)(5660300001)(65826007)(316002)(7736002)(47776003)(26005)(77096007)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0693;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-2?Q?1;BY2PR12MB0693;23:FP6mIAeg0dhG1M2BFqRCFmiJumskVTI3swNoO3+?=
 =?iso-8859-2?Q?FfkY6lMcsOWLJ6qdwRX57w38WhOOaINEXAoqBvmrpQmIVK5N4BZIn0e60G?=
 =?iso-8859-2?Q?pt6hvTZmu3czZ8CvHvaig3Iiurh5g/KcnaoeO8YTF8RXLnigKblV2LQFF0?=
 =?iso-8859-2?Q?mOt3OgvVxA8g+yFlEc1J+B7TyOHf7mMHHQtnDvLQnlz7gXdpnoan01Q1le?=
 =?iso-8859-2?Q?LFwepYpOxsEJpsGTxTLo3DCBOuEHu9ghpXaDXE2J9FKod4eDjl2XGvZtya?=
 =?iso-8859-2?Q?xboIU350Onh492aiJ8pe2UZZEtcwyxvBc3O6QX7dIbhhkN0zeordMRUtrs?=
 =?iso-8859-2?Q?FVqG5nqnouaTzardw3YGli/cLsA/INRBbpcFGF5EbVC1m9ExRannKTrIsG?=
 =?iso-8859-2?Q?ic25toMbXk3k4FFCVPyCSmDGbC5gIyZDxTmPUXZcxvaNLXxnE8KkWndeKB?=
 =?iso-8859-2?Q?0xsFKtCEJMAu5i1XCEG9QqcfD+ic37FasuwS8Bk8NB8i9zLznjrAxMLyQF?=
 =?iso-8859-2?Q?rMsRCEqQt7pE8zTdmRRKxcxCUGU4HB5aMRoUNP9E7y9FN+xYW7zV1ALf1E?=
 =?iso-8859-2?Q?Az1LBRzVoIf9gAKUH2yK4b6XpJvvkgVwxl6UzqV6s2TW0cDm2C/9qmpuhw?=
 =?iso-8859-2?Q?iGyiwt0Y6JFzOdNtV8I9z1SJssP/NQUR3ynQNb+UwXUGAvivBnb/Z78HE6?=
 =?iso-8859-2?Q?C7yhMKj59PVfgHttsAP5CNfrJ6xOSqIKg7QUtcJLGMSRVmty1orVT6hvA1?=
 =?iso-8859-2?Q?lSZBPk9v/GlTcLB/Ja2KhsJ0Zfg4O8fW+q3NNmrzhVTm/SaDpFPU+8xPRU?=
 =?iso-8859-2?Q?jPzAsvwJQJ4ypk8BZZtky2fxXhsabjLdlxkctigoh1ZiRLRxDrNGqGLtn2?=
 =?iso-8859-2?Q?E9Hey2SZEvlNrRPyITW8u9PWLAXT7Rvmvq5zMBm24YxIxjL4u66elNI0f0?=
 =?iso-8859-2?Q?f30mI/5C2+NalTNkZXMDGfsQ2excIUIE/n6JuwgMKbJVvKF6aNyEhagt6L?=
 =?iso-8859-2?Q?v8Rov6XX/KwXmIVROdO9IMTdXy+u3Yc6x9zqNkhUb7z25fmhL0IWcNA+lm?=
 =?iso-8859-2?Q?V4N8c9z6lBWsNR1cHyH0piKJYqCl/1rbYz3KR8D7A+yDjMH7fta0D3yr6O?=
 =?iso-8859-2?Q?lJ5pbq+5aXDkVqxlHJbmtqDCqfbMTG+ki03gXrnYRZVlKf1yOJyTteWwhp?=
 =?iso-8859-2?Q?zaFzp1C8RLxix7LMYciJpZU0E6k0pCGV0dxU4o6E+Dwe5jcuVVvSwRCcQH?=
 =?iso-8859-2?Q?p6rHadGd3K2OmdG7rEUJ5eGAX5qJpj/JN92sIL3xSXJkH+xCouacd92dIZ?=
 =?iso-8859-2?Q?42NfQG0ILIi1dCR/6u9mal8wkvlsBEzL96QP8O0GiPCe5VCvy5pxT1o6dg?=
 =?iso-8859-2?Q?mf77/2S4C0Y3EPGPjEBoCCmtdhKyMSCuufqePPYb+swhgEvvCldfdAEFVh?=
 =?iso-8859-2?Q?GGT0cKDkLozJjS7Clttwo4CapW2s2GFl41kcBNeYjeVAPgoMztiUrxJJqq?=
 =?iso-8859-2?Q?rgpAB2YHPNR+lKcAqJCc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;6:aHM3WlBxOPE7UeFR8HxHcgU9vcDW97llU+CGuy2gtdIuGxmJCVwm60jKytSqoXPrD2MIiytCnoH+jC0NJpU+JFr5EbLKUwcnvb49yKKV84ap3z+rZkrap4xS7u05jDVCSZ55JTpQkPSFAfhTdivPj/16bOAOJ3h85xirQnZvEnMHLLQxsAdlqg9Yuxr7lcLX3cbJ9heeMBle55lzn37AcMUrOjgef2t5e/MsFzQ3kP6S1cbWnqrHecI+OGYprs5miM0ITvmJVulw12Ou6Y6p9YN3tq+JvgKUTfKIdgrhUOIg2KpvT4YTmCDPRXrhUirrmly0AXpek6IsqFAXPBx+BG7lZuw+q7Q/QJYNqfeNVgc=;5:son28TjlxvtxBR62tDw1An8AgG7fY8sLq3C7HPagL6oEL3zyITI3Vo5Wp8pQ7yR52uXTQNaSObZKRPEOw0TafCtCOZn16GBUq3Np2WGwTqKydeent6VgOcWzHuEnBUN230d4jkwwqos+SG+oVf7J6LWpjdNMF5MiBMPLwTqmUUM=;24:yDCDxwUM0Q1ioJCgZqoDDCDeAFDCAF1yxXVLUEQRoo/8ogYk/QovCXclyx6Pf9arIErbPJaylfsFnPkrXRu9n3h4heeQDOVMMciv4G9EJ4A=;7:V8DC+uflB9s6KKIGigXRHjL0rB54f2/JMaWban5Lw/kgxTFj4dAjtvNOrvtr1RDsx2UxR+GQKZZRxbuChPQVUxLP3GxJn3bYaHNpZ6WSp2jRIz/6pS3nj39fdkUeZaAOCAAjHLS8jwsypUGVh6OdBEM1gDiDRE24hZWnknPqSx+3rI8iIeMFp7hzXtY6OkiUuuC2SyQ6lGWXjxo7ctaQKl84Bv55yUpIOgb97i2JV6RlGa4usy6lDp0iflwac4II
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:Fez7dL5Au4q300Q5dAN9eX5z4OTtnwjwnUNo2s94O5oazuFq6Y29GyQJcmD2RlFhlfuICouxztRCRQ/TQSVN/IZDfOLkKu9HOnuruJ6fq1ZmBmtMX4nUioUqE+kyqxkGyu9I8mtBgok4UWZxR947GgwSMbCwxUxQSXsBkDmfnl6o2dDmrxmA4RHLvdWrX6WPkZC0qHdnH96z623UdO/ijdK5A4lNoTWQzJgm0bDfTMuP1xlrTQ/ZNCSckRNSVLs1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 00:35:10.5823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc08457c-9ca4-40ca-f80b-08d57f0c4ab7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0693
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/2018 10:03 AM, Maciej S. Szmigiero wrote:
> CCP RSA implementation uses a hardware input buffer which size depends only
> on the current RSA key length. Key modulus and a message to be processed
> is then copied to this buffer based on their own lengths.
> 
> Since the price for providing too long input data is a buffer overflow and
> there already has been a case when this has happened let's better reject
> such oversized input data and log an error message in this case so we know
> what is going on.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>   drivers/crypto/ccp/ccp-ops.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
> index 406b95329b3d..517aeee30abf 100644
> --- a/drivers/crypto/ccp/ccp-ops.c
> +++ b/drivers/crypto/ccp/ccp-ops.c
> @@ -1770,10 +1770,6 @@ static int ccp_run_rsa_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
>   	if (!rsa->exp || !rsa->mod || !rsa->src || !rsa->dst)
>   		return -EINVAL;
>   
> -	memset(&op, 0, sizeof(op));
> -	op.cmd_q = cmd_q;
> -	op.jobid = CCP_NEW_JOBID(cmd_q->ccp);
> -
>   	/* The RSA modulus must precede the message being acted upon, so
>   	 * it must be copied to a DMA area where the message and the
>   	 * modulus can be concatenated.  Therefore the input buffer
> @@ -1785,6 +1781,26 @@ static int ccp_run_rsa_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
>   	o_len = 32 * ((rsa->key_size + 255) / 256);
>   	i_len = o_len * 2;
>   
> +	if (rsa->mod_len > o_len) {
> +		dev_err(cmd_q->ccp->dev,
> +			"RSA modulus of %u bytes too large for key size of %u bits\n",
> +			(unsigned int)rsa->mod_len,
> +			(unsigned int)rsa->key_size);
> +		return -EINVAL;
> +	}
> +
> +	if (rsa->src_len > o_len) {
> +		dev_err(cmd_q->ccp->dev,
> +			"RSA data of %u bytes too large for key size of %u bits\n",
> +			(unsigned int)rsa->src_len,
> +			(unsigned int)rsa->key_size);
> +		return -EINVAL;
> +	}

We've talked about this, and we believe that a more central fix is 
warranted. I intend to post another patch tomorrow that should address
this problem.

> +
> +	memset(&op, 0, sizeof(op));
> +	op.cmd_q = cmd_q;
> +	op.jobid = CCP_NEW_JOBID(cmd_q->ccp);
> +
>   	sb_count = 0;
>   	if (cmd_q->ccp->vdata->version < CCP_VERSION(5, 0)) {
>   		/* sb_count is the number of storage block slots required
> 
