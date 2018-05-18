Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeERUaO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:30:14 -0400
Received: from mail-ve1eur01hn0206.outbound.protection.outlook.com ([104.47.1.206]:35584
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751805AbeERUaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:30:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Fri, 18 May 2018 23:29:50 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org, Cathy Avery <cavery@redhat.com>
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
Message-ID: <20180518202950.GA759@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org,
        Cathy Avery <cavery@redhat.com>
References: <20180510191634.18796-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510191634.18796-1-rkagan@virtuozzo.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0195.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::19) To HE1PR0801MB1980.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1980;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;3:yxNGoAhBD6bhkiUK5ApfQqGZ4M+41RFoqEIbwAzwdSAuxapd0Ctq6JHSFVDAcW4404MaxGIBaL5aTfeW24zgmwDruESQSm22zpvIubLmWoM1PX7olTzJv/DppeV27Hbn7Mvd65lI+IiB03k3hzxV7ck6bOvXTe94Qul0Kahkn93i8UGr9UmjGiXqHJ8NyuHt7g3IUFPh34CLV46/OA9ZwvvQcvglnDiIhjrcfTm01RjgdOAidahLG79dlqCiQZYq;25:kVTD9CnmvuTARiSdHRTZbTXAoRogBj4orB0qHdLf4YWnedaJCI5wH0X6QTaqhS/mqcAon7gqiyVBlQTSag+r6/7hLebMobDQZ7HxIYxotDoe/Ki3lkYB+UkO3YmNlHO3xanvQQ9HxmhnbLujxPgaiBLb9bUcYRDqzXCxvTaW7zoOmzrzQma6lRGtTfu0z1ZoKicSHFp2mxKsS/vnXeYjHl8QglK8Plwb0D/W/AgUJOf+jYBrxupC6eiqZugsF8S2UpzJLSF8uh6lll+mAgp1i+4MZ7sbO+tL3GUDo6ioLXRtn7DNBtCaBbce2v5dYiGejHd7fIiIKRU4335i5TNokg==;31:eMSxXDKilPbD08sGLtUJZr2l2wl0KZzQFdWGVhE5cCtYGRUxvfpSDpHomCoIei8Z6oEkU790vJ0jstQKz+njy3q/bYFtqz3pvXIaH35xY0Zygob05CbOy6PsKx/ClpsN4OFfjA9dxIjb+fsmnt5VMiarLjMYF0DpKJoVhIqus/S6IYug0Hi1D6Vlcm00AA2Frp5XNKJOtb5c6Yl2bceQia3pBhU/zmJNTem5CJ+JPeM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1980:|HE1PR0801MB1980:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;20:zsohJJugTPkOPAdZCxJwc3uW/I8aOWSlDOKIMI0wWowScmUN5AAoMiYgfYTK/xkriiV2O37jGM1YyPGpt5WVK9g/ILqPL7eAXPJOPnQi9eB6wj15Z2WEqxFobVZnA/jBSF+/Q6pHxxcOcyxfjvzzy61qLmC0sMoRKm34aun6+8TqnH1Ole6CaWaSglaHGpGoyxW76tHoSVH7hZmVBRf+1a0QbxCTuRR3sAUh+MIxzW8DTq00fgbsXeXceMann7IlLTBWbt8aJkU2rryqmPIXovPFdKL408pQG7KTAQUI0HGDu2IBIr6ekmJvEqKTfCOJQV/nLPKOe///6cz1DTPMn4GXOoLkda3/RmE7GD1RTVZrwoTLddD/kiL7bKWBfVbR5UOm1zwtI43iayUCuYoJqOGDHcU1YeTagSXX2/GdkKqaxJ3WmqBx6HyZhTJWpOuXxnuaZNx3jxzna6bQAt8bptjWGq6YbkYJGJgAdpDkDxXWyMpuUw3RS16I14O7DWV+;4:zPbD8nmpXrmpVmSCPxiYgeA8tcqSB7SEmN/zT/rNnBiLEU9p2a/8qYCvWM9U3NbCKYcXlknZkBm8QbjSS0NHQz9mkA6YVkx7HB9hzfpN5b8jlu0R3dKIefVXSAOmfr9CMQFsQqVYG0C+kDqAMThNkVnRoHkCba39OQT7z4X4PLV5+w635PObHnE5oGb/7+V7wTRn9hvYMOTYaqq/fJOm/s9ice1nqg9pV802b4stJIp4zExWP7n5fLH75l19HLJO1dfc+RPa2at+g9CZ5hUFa9wJOdKnazfWLvOCkmo3WCCggpEDWCySzaJk/NTZSHy/DCXvhwWnwrEii+U5PH2DZZbCdloWGahBoIVb0vjeNagTjnubKCd3lKQcmxJbuC7o
X-Microsoft-Antispam-PRVS: <HE1PR0801MB198037445880E4D4F51A2E02C9900@HE1PR0801MB1980.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1980;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1980;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(376002)(39380400002)(39850400004)(346002)(366004)(396003)(189003)(199004)(81156014)(6246003)(8936002)(68736007)(81166006)(8676002)(446003)(26005)(16526019)(186003)(11346002)(476003)(956004)(53936002)(33656002)(386003)(59450400001)(66066001)(106356001)(1511001)(486006)(76176011)(47776003)(105586002)(52116002)(7696005)(6506007)(9686003)(55016002)(50466002)(55236004)(36756003)(7416002)(58126008)(110136005)(69596002)(6666003)(45080400002)(4326008)(478600001)(53416004)(16586007)(316002)(5660300001)(305945005)(7736002)(2906002)(8666007)(584604001)(25786009)(86362001)(23726003)(97736004)(575784001)(1076002)(3846002)(6116002)(229853002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:HE1PR0801MB1980;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1980;23:J5B27QoDgbK7zLKBzOGbQUUh7qRloOPlpQHeaUj?=
 =?us-ascii?Q?T9ZvwGq/1OXpwqg2TRXLgrtOCktM09+p63cAuaNwaZBOaQoiz9jiDg+wzTWk?=
 =?us-ascii?Q?gxIMUfKfnwx1+62EocAVxXpVhIgv80+8ezoHvDSeV/n8NtzjG7sQGf0F2nff?=
 =?us-ascii?Q?GKrurNRazM2a7mWtXLBnicCgw/0RwNX87Tv4pfbgqssNDI33EUVv374cDWn5?=
 =?us-ascii?Q?5GaY1Vj8MOziAxXnGTQrxJDyobl7cmxcdvAPp+j9ylAebCjtQEj/HRDAlvOQ?=
 =?us-ascii?Q?nGj5m8nhHgOI/XtY6uvWxAkq7R29KLNE8OPQO9PAvl9Xt2MUvOG61Otn9vAg?=
 =?us-ascii?Q?DeyBM7h7FlTS/sifa5WC4ndYCbK7/leym+cKOvjODhDiHuivCIpBfaSES+zS?=
 =?us-ascii?Q?GewxrONN81t4Azql3wtYNVPbEKG3mgpawYF1yVx3VkOZ75e8VNI9fn91sIeI?=
 =?us-ascii?Q?kvhbww8sHmV0TjMBcer53fj9PNIrEvtOdFAMalqIGP7nL/bpD2yroCHwOWs5?=
 =?us-ascii?Q?zyD859fijSTns3DNWnKrU0NPTXZ6ei8hj3qFkx2fbOOD+eEOnB/xi0CDz0ki?=
 =?us-ascii?Q?VAyOe3v3w1oY1l9iHzcHr3MBlHCGL3Yo6xGP4WtobgTPiOlKIemQPn4YpRBY?=
 =?us-ascii?Q?zSah8sT0FPKasJJTGkFj8ruUvqgH/R0KU/xs2zE3PcDAoi6WeVIbG1tryd2M?=
 =?us-ascii?Q?TV3G5uJadwmJ29+uBxyQluH3x7+e6Chl597l3BDzi1eYE600txtYq42F8qqU?=
 =?us-ascii?Q?39CE04ZTTXMvtGb11dfiEC0cC7SkFhmmBiCgYyADiyQfoj3d26TJsyXYJ536?=
 =?us-ascii?Q?st6A5m/nlG4sJFjGQAt0HUhnTY8gOlSihTPj9kQfniY1UBX3kG0D0oZfN5eM?=
 =?us-ascii?Q?A6jEbNtQzpfbUanPPaAFq6YxfauhwzS2vSVa9Gq40deAwtuR4iupYsIpyCTT?=
 =?us-ascii?Q?FY/0Sag1mo3gbD3oBDMSceXubH7+yvSXll8jZmMNG2vB2HDr6FC4E5g13cCM?=
 =?us-ascii?Q?nZkD3qc8ZtFlA1+qYMAcI3JkF1QPfPA6Mnk4woOETUma2S5jNsOjQTDUdZmk?=
 =?us-ascii?Q?0gsg9KRmnGV3gE4KXrbKYJ+2fNZuDUhrioYl4XfpZU6OHoYzXgvrOBOsYzIr?=
 =?us-ascii?Q?aLZf1oApsjYq45HkF06z4U318Iu+EVWNc2tZRWxvFuqyRBd5uVPGCLYEREyE?=
 =?us-ascii?Q?gMmqBSYyGQ9wnS/yhx9z5MJfkF/LnqABk5GXmQRE+wu6vZ2YZMSVjYeTxOtK?=
 =?us-ascii?Q?aI/9MgS42zuP03v6oC/YYFOnvXZx2n6EAu71Ck5geDx9DD5qByebVTDWTQvk?=
 =?us-ascii?Q?/Qc0H9utsqDrklmhHdoHeBvt6Irc4RFd0hJLA9RWY9xPksTphJMV+GPl5Sjy?=
 =?us-ascii?Q?uNBDKIn1gBbT/2SqhAL7wHuJgzuEhXWBNjK3xqrWIoxAwvlnJlqk45yOTIK/?=
 =?us-ascii?Q?G3CkEO2EOPVnnU12GA7t7NsqU7ICNDSiesnzWNrv5AOmdG9LO4ianY9/uylr?=
 =?us-ascii?Q?iak5sqc+rsm0aw6VkrFa5wP3X8PvZJkdvTcEGybJf7heyvZbbUPvfBdy5?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;23:QxNgU+Y6IHBFAzN8xmWNH/6hdD5yNIknQM4MB/Pr1kKpMuJQlaG6iNRz37SsqTuYvZT76dFbgSCbervP0h9zFiOhWyN3d46eHxm1Q8EgcITiRkgxIdwAyEll17o/i71YzctxJ8OrySzHEJihr6vFGw==;6:4ocKH7TFrXF9PP7sZisJMv9n5p4Z2uhmFOylsGg26l5MVNwXMiM56jxXMyYnC+hg5tZL44GvnbtdolUtz3unR6FeYFL6W/cRiw6rFokBMhLoHt3icMqPBnPHznYMGqz+CWbFkQp7rvJ6QDRPNs/DzUTwadpQy/rR/B2ikbA/FY1l4fSsekgAWhN9A45Xme8O1oWygyCPVKnQNwReG8QPM/s77w36An28SJSF2jY9wb5+v61A2w3sSH/zmJTQlf9ThcU1bzR7DcI+JTy5U4wQd3Dx50nt/4vDg7BykSC8qnVmW4uvEllZbgillCUEP1lNFpdcGzrovnLArrMjNxulGk+YBd3otzbGxbLDES8rVrnadHe1YjcQvVw117P+hUdaNCD2LFbUBhuIZBb7evr/vHrT9QTHJcapaHsuONxxxvSo42PFNcb2Nl4xVXx57ZCASiQmgI+9rAaA8cThBA1U9E6e7HPCJuRVnr6YUk0H9TPtBf80WddMJ8YiLlSGO7ca;5:byVbBjcetyEM5EX8IYkzIzbRaO8YB+nCu9AULiKBDLEcJ5rWOi8lUQKq9NE9h71LN0fu3xkBQsYtan2ygVLidP0ApUdE66u5PizuSU2VUQSKeh7ACQWjm2N4uvwADqsSCygYCHoqHbxzQLIsmfaLhOglvAJXUifS4B6osus5fFQ=
X-Microsoft-Antispam-Message-Info: yJmydaISaTa4cfCgk2cThMBKrUQQx7b47ywy8CFAEF/aiPsyZC1NywwpcVdorMwCJKW+DGrHx0/HFPo5/tNNXGg6Mf4vjN90GU0Tw8oS0FuUM0WcnRfSBFnOPYkf1l1DUV+eflFO5gWO5UVgOhcNfdkSXr2R5E7PPpJ/Ns2GHiYk8K5gSel6we7mVX+XT+lbIV37rwXV6FycRlrUNQXO+wrP5lr6DTS8xMJyNUPMfjtp8gGyIWLxE1it0ekg70X7XzYD+4HKemqRmto4SUmkrMiSMmHagSRfBIHri7I1ZCTM6R7H5TeVQ9bz0tVeLHKZxlZnxoN32nZY/xV7AbaHZBfw2M9vl4Ek6Q1IuMDWsGaEMGCd0zt+ICkPS4S72pLY957xJxos3LjEGS72e6AJK7pkkSGm8U4ypBtDLVz0pOg=
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;7:mPsfuiCC0qMkVXMglZyQ5f6Z54JeY7k291SBmKFX/y/CXDIZVtTvfXqxm2l754Ew6CgNBAFa2YlrF0AQfONwtCzmVM1hNcZL9kBwwnpM/JAeB9XNFb0Y7gMpfQs4Yyfusmpzrl9hk/3o8EGDDnOOkeWkFq0YLcvSclsCh5ZrynOzF4p7yKrh3b/E8rp/7mYZV8G/ktznqc500wiOcuFxe4Pb9aWwBJQxneMhKnPSl2XTkEI068/TLI8zR2jhIFXw;20:83crtXb7hyHialGXrw0y/V1CdtOUBlQgtyfFGjfOGHR4FikeHG5HceUXRMotXRHQEGta3RXwp8IOJTMZalnP8gwrWEKq4zIEwrFCLxxX54m990oC2P9T19NYi//HMNJnfZdKHixtVUCljb00sd8PbKSQXuLua7wKwGbMZlls5gk=
X-MS-Office365-Filtering-Correlation-Id: 73cb4400-a8ae-42e9-a477-08d5bcfe1de1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 20:29:54.7304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cb4400-a8ae-42e9-a477-08d5bcfe1de1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1980
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 10:16:34PM +0300, Roman Kagan wrote:
> If an IDR contains a single entry at index==0, the underlying radix tree
> has a single item in its root node, in which case
> __radix_tree_lookup(index!=0) doesn't set its *@nodep argument (in
> addition to returning NULL).
> 
> However, the tree itself is not empty, i.e. the tree root doesn't have
> IDR_FREE tag.
> 
> As a result, on an attempt to remove an index!=0 entry from such an IDR,
> radix_tree_delete_item doesn't return early and calls
> __radix_tree_delete with invalid parameters which are then dereferenced.
> 
> Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  lib/radix-tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> index da9e10c827df..10ff1bfae952 100644
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -2040,8 +2040,9 @@ void *radix_tree_delete_item(struct radix_tree_root *root,
>  	void *entry;
>  
>  	entry = __radix_tree_lookup(root, index, &node, &slot);
> -	if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
> -						get_slot_offset(node, slot))))
> +	if (!entry && (!is_idr(root) || !node ||
> +		       node_tag_get(root, node, IDR_FREE,
> +				    get_slot_offset(node, slot))))
>  		return NULL;
>  
>  	if (item && entry != item)

Turned out Matthew didn't receive my messages; now that he's found this
patch elsewhere he's responded with a correct fix:

----- Forwarded message from Matthew Wilcox <willy@infradead.org> -----

Date: Fri, 18 May 2018 10:50:25 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete

It'd be nice if you cc'd the person who wrote the code you're patching.
You'd get a response a lot quicker than waiting until I happened to
notice the email in a different forum.

Thanks for finding the situation that leads to the bug.  Your fix is
incorrect; it's legitimate to store a NULL value at offset 0, and
your patch makes it impossible to delete.  Fortunately, the test-suite
covers that case ;-)

Andrew, can you take this through your tree for extra testing?

--- >8 ---

From: Matthew Wilcox <mawilcox@microsoft.com>

If the radix tree underlying the IDR happens to be full and we attempt
to remove an id which is larger than any id in the IDR, we will call
__radix_tree_delete() with an uninitialised 'slot' pointer, at which
point anything could happen.  This was easiest to hit with a single entry
at id 0 and attempting to remove a non-0 id, but it could have happened
with 64 entries and attempting to remove an id >= 64.

Fixes: 0a835c4f090a ("Reimplement IDR and IDA using the radix tree")
Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
Debugged-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index da9e10c827df..4dd4fbc7279c 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2036,10 +2036,12 @@ void *radix_tree_delete_item(struct radix_tree_root *root,
 			     unsigned long index, void *item)
 {
 	struct radix_tree_node *node = NULL;
-	void __rcu **slot;
+	void __rcu **slot = NULL;
 	void *entry;
 
 	entry = __radix_tree_lookup(root, index, &node, &slot);
+	if (!slot)
+		return NULL;
 	if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
 						get_slot_offset(node, slot))))
 		return NULL;
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 1c18617951dd..410ca58bbe9c 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -254,6 +254,13 @@ void idr_checks(void)
 	idr_remove(&idr, 0xfedcba98U);
 	idr_remove(&idr, 0);
 
+	assert(idr_alloc(&idr, DUMMY_PTR, 0, 0, GFP_KERNEL) == 0);
+	idr_remove(&idr, 1);
+	for (i = 1; i < RADIX_TREE_MAP_SIZE; i++)
+		assert(idr_alloc(&idr, DUMMY_PTR, 0, 0, GFP_KERNEL) == i);
+	idr_remove(&idr, 1 << 30);
+	idr_destroy(&idr);
+
 	for (i = INT_MAX - 3UL; i < INT_MAX + 1UL; i++) {
 		struct item *item = item_create(i, 0);
 		assert(idr_alloc(&idr, item, i, i + 10, GFP_KERNEL) == i);

--- original email ---

If an IDR contains a single entry at index==0, the underlying radix tree
has a single item in its root node, in which case
__radix_tree_lookup(index!=0) doesn't set its *@nodep argument (in
addition to returning NULL).

However, the tree itself is not empty, i.e. the tree root doesn't have
IDR_FREE tag.

As a result, on an attempt to remove an index!=0 entry from such an IDR,
radix_tree_delete_item doesn't return early and calls
__radix_tree_delete with invalid parameters which are then dereferenced.

Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 lib/radix-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index da9e10c827df..10ff1bfae952 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2040,8 +2040,9 @@ void *radix_tree_delete_item(struct radix_tree_root *root,
 	void *entry;
 
 	entry = __radix_tree_lookup(root, index, &node, &slot);
-	if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
-						get_slot_offset(node, slot))))
+	if (!entry && (!is_idr(root) || !node ||
+		       node_tag_get(root, node, IDR_FREE,
+				    get_slot_offset(node, slot))))
 		return NULL;
 
 	if (item && entry != item)

----- End forwarded message -----
