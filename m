Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD146C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A9220656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfANWiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:38:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:43343 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfANWiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:38:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 14:38:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,479,1539673200"; 
   d="scan'208";a="291537241"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2019 14:38:10 -0800
Subject: Re: [PATCH v10 03/12] peci: Add support for PECI bus driver core
To:     Joel Stanley <joel@jms.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Julia Cartwright <juliac@eso.teric.us>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com>
 <20190107214136.5256-4-jae.hyun.yoo@linux.intel.com>
 <CACPK8XfxU6r_0HLbD2MuSgON5-G43cpENhK+SR=9KhBG4GeWDA@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <68876b15-f0fb-e9dd-a4aa-e9b5c50f4a54@linux.intel.com>
Date:   Mon, 14 Jan 2019 14:38:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACPK8XfxU6r_0HLbD2MuSgON5-G43cpENhK+SR=9KhBG4GeWDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joel,

On 1/14/2019 3:13 AM, Joel Stanley wrote:
> Hello Jae,
> 
> On Tue, 8 Jan 2019 at 08:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> This commit adds driver implementation for PECI bus core into linux
>> driver framework.
> 
> I would like to help you get this merged next release cycle, as we are
> now carrying it in OpenBMC. I suggest we ask Greg to queue it up if
> there are no objections after you've addressed my questions.
> 

Thanks a lot for your help on reviewing this patch series. I'll submit
v11 to address your comments. We could ask Greg to queue it then.

>> +static u8 peci_aw_fcs(u8 *data, int len)
> 
> I was wondering what aw_fcs meant. I notice that later on you describe
> it as an Assure Write Frame Check Sequence byte. You could add a
> comment next to this function :)
> 

Agreed. I'll add a comment like you suggested.

> Instead of casing to u8 every time you call this, you could have this
> take a struct peci_xfer_msg * and cast when calling crc8.
> 

Yes, that would be neater. Will fix it.

>> +{
>> +       return crc8(peci_crc8_table, data, (size_t)len, 0);
>> +}
>> +
>> +static int __peci_xfer(struct peci_adapter *adapter, struct peci_xfer_msg *msg,
>> +                      bool do_retry, bool has_aw_fcs)
>> +{
>> +       ktime_t start, end;
>> +       s64 elapsed_ms;
>> +       int rc = 0;
>> +
>> +       /**
> 
> These are for kerneldoc, and the comments aren't kerneldoc. Replace
> them with /* instead.
> 

Okay, I'll check all comments again in this series.

>> +        * For some commands, the PECI originator may need to retry a command if
>> +        * the processor PECI client responds with a 0x8x completion code. In
>> +        * each instance, the processor PECI client may have started the
>> +        * operation but not completed it yet. When the 'retry' bit is set, the
>> +        * PECI client will ignore a new request if it exactly matches a
>> +        * previous valid request.
>> +        */
>> +
>> +       if (do_retry)
>> +               start = ktime_get();
>> +
>> +       do {
>> +               rc = adapter->xfer(adapter, msg);
>> +
>> +               if (!do_retry || rc)
>> +                       break;
>> +
>> +               if (msg->rx_buf[0] == DEV_PECI_CC_SUCCESS)
>> +                       break;
>> +
>> +               /* Retry is needed when completion code is 0x8x */
>> +               if ((msg->rx_buf[0] & DEV_PECI_CC_RETRY_CHECK_MASK) !=
>> +                   DEV_PECI_CC_NEED_RETRY) {
>> +                       rc = -EIO;
>> +                       break;
>> +               }
>> +
>> +               /* Set the retry bit to indicate a retry attempt */
>> +               msg->tx_buf[1] |= DEV_PECI_RETRY_BIT;
>> +
>> +               /* Recalculate the AW FCS if it has one */
>> +               if (has_aw_fcs)
>> +                       msg->tx_buf[msg->tx_len - 1] = 0x80 ^
> 
> Can we guarantee that msg->tx_len will be set to non-zero whenever has_aw_fcs?
> 
> I suggest checking before doing the assignment in case a new caller is
> added and they make a mistake.
> 

The msg->tx_len is already checked by callers - peci_ioctl_wr_pkg_cfg()
and peci_ioctl_wr_pci_cfg_local() - so it's not needed to be checked
again at here.

>> +static int peci_ioctl_get_dib(struct peci_adapter *adapter, void *vmsg)
>> +{
>> +       struct peci_get_dib_msg *umsg = vmsg;
>> +       struct peci_xfer_msg msg;
>> +       int rc;
>> +
>> +       msg.addr      = umsg->addr;
>> +       msg.tx_len    = GET_DIB_WR_LEN;
>> +       msg.rx_len    = GET_DIB_RD_LEN;
>> +       msg.tx_buf[0] = GET_DIB_PECI_CMD;
>> +
>> +       rc = peci_xfer(adapter, &msg);
> 
> Most of tx_buf is going to be uninitialised. I assume a well behaving
> adapter->xfer will check this and only send the correct number of
> bytes, but it might pay to zero out struct peci_xfer_msg in all of
> these functions?
> 

The tx_buf will be initialized only amounts it needs to be in each
command. The adapter->xfer is handling exactly up to msg->tx_len so
it would be better keep the current code without using zeroing out the
struct.

>> +       if (rc)
>> +               return rc;
>> +
>> +       umsg->dib = le64_to_cpup((__le64 *)msg.rx_buf);
>> +
>> +       return 0;
>> +}
> 
>> +
>> +#if IS_ENABLED(CONFIG_OF)
>> +static struct peci_client *peci_of_register_device(struct peci_adapter *adapter,
>> +                                                  struct device_node *node)
>> +{
>> +       struct peci_board_info info = {};
>> +       struct peci_client *result;
>> +       const __be32 *addr_be;
>> +       int len;
>> +
>> +       dev_dbg(&adapter->dev, "register %pOF\n", node);
>> +
>> +       if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
> 
> I don't understand why you're doing this. Won't this always be peci,
> as your binding requires?
> 

Since it supports only 'intel,peci-client' for now, it's not needed
actually. I'll drop it at this time. It would be added later if needed.

>> +               dev_err(&adapter->dev, "modalias failure on %pOF\n", node);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       addr_be = of_get_property(node, "reg", &len);
>> +       if (!addr_be || len < sizeof(*addr_be)) {
> 
> The second check looks suspicious.
> 
> You could fix it to check the expected length (4), or use of_property_read_u32.
> 

Right, I'll fix it using of_property_read_u32.

>> +               dev_err(&adapter->dev, "invalid reg on %pOF\n", node);
>> +               return ERR_PTR(-EINVAL);
>> +       }
>> +
>> +       info.addr = be32_to_cpup(addr_be);
>> +       info.of_node = of_node_get(node);
>> +
>> +       result = peci_new_device(adapter, &info);
>> +       if (!result)
> 
> Should you do an of_node_put here?
> 

Oh, this code is definitely incorrect. I should to put the of_node
reference at here if peci_new_device() fails and should keep the
reference until peci_unregister_device() is called. Will fix it.
Thank you for your pointing it out!

>> +               result = ERR_PTR(-EINVAL);
>> +
>> +       of_node_put(node);
> 
> Why do you release the reference here?
> 

This is incorrect too. Will move the of_node_get/put code into
peci_new_device() and peci_unregister_device() to avoid confusion.
Thanks again for your pointing it out. :)

>> +       return result;
>> +}
>> +
> 
