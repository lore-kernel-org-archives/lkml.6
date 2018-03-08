Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966334AbeCHNkv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:40:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46150 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966282AbeCHNkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:40:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 08 Mar 2018 19:10:47 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] i2c: qup: schedule EOT and FLUSH tags at the end of
 transfer
In-Reply-To: <20180227223654.GE20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-5-git-send-email-absahu@codeaurora.org>
 <20180227223654.GE20901@hector.attlocal.net>
Message-ID: <bc9c8dced56448f69ebad0848f5c0f34@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-28 04:06, Andy Gross wrote:
> On Sat, Feb 03, 2018 at 01:28:09PM +0530, Abhishek Sahu wrote:
>> A single BAM transfer can have multiple read and write messages.
>> The EOT and FLUSH tags should be scheduled at the end of BAM HW
>> descriptors. Since the READ and WRITE can be present in any order
>> so for some of the cases, these tags are not being written
>> correctly.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>>  drivers/i2c/busses/i2c-qup.c | 54 
>> ++++++++++++++++++++------------------------
>>  1 file changed, 24 insertions(+), 30 deletions(-)
>> 
>> diff --git a/drivers/i2c/busses/i2c-qup.c 
>> b/drivers/i2c/busses/i2c-qup.c
>> index bb83a2967..6357aff 100644
>> --- a/drivers/i2c/busses/i2c-qup.c
>> +++ b/drivers/i2c/busses/i2c-qup.c
>> @@ -560,7 +560,7 @@ static int qup_i2c_set_tags_smb(u16 addr, u8 
>> *tags, struct qup_i2c_dev *qup,
>>  }
>> 
>>  static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
>> -			    struct i2c_msg *msg,  int is_dma)
>> +			    struct i2c_msg *msg)
>>  {
>>  	u16 addr = i2c_8bit_addr_from_msg(msg);
>>  	int len = 0;
>> @@ -601,11 +601,6 @@ static int qup_i2c_set_tags(u8 *tags, struct 
>> qup_i2c_dev *qup,
>>  	else
>>  		tags[len++] = data_len;
>> 
>> -	if ((msg->flags & I2C_M_RD) && last && is_dma) {
>> -		tags[len++] = QUP_BAM_INPUT_EOT;
>> -		tags[len++] = QUP_BAM_FLUSH_STOP;
>> -	}
>> -
> 
> So lets say you have multiple read and 1 write message.  These changes 
> will send
> a EOT/FLUSH for all reads.  I think the intent here was that the last 
> read
> message (not the last message) would have the EOT+FLUSH.  Can there be 
> an issue
> with sending EOT/FLUSH for all reads?  And how does this mesh up with 
> the BAM
> signaling?
> 

  Thanks Andy and Austin for reviewing these patches.

  The role of FLUSH and EOT tag is to flush already scheduled descriptors
  in HW. EOT is required only when descriptors are scheduled in RX FIFO.
  If all the messages are WRITE, then only FLUSH tag will be used.

  Let’s take following example

  READ, READ, READ, READ

  Currently EOT and FLUSH tags are being written after each READ. If we
  get the NACK for first READ itself, then flush will be triggered. It
  will look for first FLUSH tag in TX FIFO and will stop there so only
  descriptors for first READ will be flushed. We need to clear all
  scheduled descriptors to generate the completion.

  Now this patch is scheduling FLUSH and EOT only once after all the
  descriptors. So, flush will clear all the scheduled descriptors and
  BAM will generate the completion interrupt. For multiple READ and
  single WRITE also, this will work fine.

  I tested with
  - single xfer with multiple read messages
  - single xfer with multiple write messages
  - single xfer with multiple alternate read and write messages

  for non-connected address in forceful DMA mode which will generate
  the NACK for first byte itself.

  Thanks,
  Abhishek
