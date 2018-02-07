Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754461AbeBGUSh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:18:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754002AbeBGUSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:18:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Feb 2018 14:19:54 -0600
From: wenxiong <wenxiong@linux.vnet.ibm.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@fb.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
        wenxiong@vmlinux.vnet.ibm.com, wenxiong@us.ibm.com
Subject: Re: [PATCH]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <20180207012353.GD13470@ming.t460p>
References: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
 <20180206163347.GG31110@localhost.localdomain>
 <787e4960b62a03b3888c67e73d7e1ee2@linux.vnet.ibm.com>
 <20180207012353.GD13470@ming.t460p>
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
x-cbid: 18020720-0024-0000-0000-000017E75452
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008492; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000249; SDB=6.00986386; UDB=6.00500582; IPR=6.00765751;
 BA=6.00005819; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019428; XFM=3.00000015;
 UTC=2018-02-07 20:18:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020720-0025-0000-0000-00004E9FAD36
Message-Id: <5974b41335751a6bc59d5c823fb98202@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-06 19:24, Ming Lei wrote:
> On Tue, Feb 06, 2018 at 02:01:05PM -0600, wenxiong wrote:
>> On 2018-02-06 10:33, Keith Busch wrote:
>> > On Mon, Feb 05, 2018 at 03:49:40PM -0600, wenxiong@vmlinux.vnet.ibm.com
>> > wrote:
>> > > @@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return
>> > > nvme_timeout(struct request *req, bool reserved)
>> > >  	struct nvme_command cmd;
>> > >  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>> > >
>> > > +	/* If PCI error recovery process is happening, we cannot reset or
>> > > +	 * the recovery mechanism will surely fail.
>> > > +	 */
>> > > +	if (pci_channel_offline(to_pci_dev(dev->dev)))
>> > > +		return BLK_EH_HANDLED;
>> > > +
>> >
>> > This patch will tell the block layer to complete the request and
>> > consider
>> > it a success, but it doesn't look like the command actually completed at
>> > all. You're going to get data corruption this way, right? Is returning
>> > BLK_EH_HANDLED immediately really the right thing to do here?
>> 
>> Hi Ming,
>> 
>> Can you help checking if it is ok if returning BLK_EH_HANDLEDED in 
>> this
>> case?
> 
> Hi Wenxiong,
> 
> Looks Keith is correct, and this timed out request will be completed by
> block layer and NVMe driver if BLK_EH_HANDLED is returned, but this IO
> isn't completed actually, so either data loss(write) or read failure is
> caused.
> 
> Maybe BLK_EH_RESET_TIMER is fine under this situation.
> 
> Thanks,
> Ming
> 
Hi Ming,

Thanks! I have tried with BLK_EH_RESET_TIMER and EEH recovery works 
fine. I am going to resubmit the patch.

Thanks,
Wendy
