Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEELvO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 07:51:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:42105 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeEELvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 07:51:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,365,1520924400";
   d="gz'50?scan'50,208,50";a="46959387"
Date: Sat, 5 May 2018 19:50:57 +0800
From: kbuild test robot <lkp@intel.com>
To: Wenwen Wang <wang6495@umn.edu>
Cc: kbuild-all@01.org, Wenwen Wang <wang6495@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: core-smbus: fix a potential uninitialization bug
Message-ID: <201805051726.NGGT2Wah%fengguang.wu@intel.com>
References: <1525484596-5585-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <1525484596-5585-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wenwen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on v4.17-rc3 next-20180504]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wenwen-Wang/i2c-core-smbus-fix-a-potential-uninitialization-bug/20180505-164208
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: x86_64-randconfig-x013-201817 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/i2c/i2c-core-smbus.c: In function 'i2c_smbus_xfer_emulated':
>> drivers/i2c/i2c-core-smbus.c:347:2: error: 'msgbug1' undeclared (first use in this function); did you mean 'msgbuf1'?
     msgbug1[0] = 0;
     ^~~~~~~
     msgbuf1
   drivers/i2c/i2c-core-smbus.c:347:2: note: each undeclared identifier is reported only once for each function it appears in

vim +347 drivers/i2c/i2c-core-smbus.c

   310	
   311	/*
   312	 * Simulate a SMBus command using the I2C protocol.
   313	 * No checking of parameters is done!
   314	 */
   315	static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
   316					   unsigned short flags,
   317					   char read_write, u8 command, int size,
   318					   union i2c_smbus_data *data)
   319	{
   320		/*
   321		 * So we need to generate a series of msgs. In the case of writing, we
   322		 * need to use only one message; when reading, we need two. We
   323		 * initialize most things with sane defaults, to keep the code below
   324		 * somewhat simpler.
   325		 */
   326		unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
   327		unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
   328		int num = read_write == I2C_SMBUS_READ ? 2 : 1;
   329		int i;
   330		u8 partial_pec = 0;
   331		int status;
   332		struct i2c_msg msg[2] = {
   333			{
   334				.addr = addr,
   335				.flags = flags,
   336				.len = 1,
   337				.buf = msgbuf0,
   338			}, {
   339				.addr = addr,
   340				.flags = flags | I2C_M_RD,
   341				.len = 0,
   342				.buf = msgbuf1,
   343			},
   344		};
   345	
   346		msgbuf0[0] = command;
 > 347		msgbug1[0] = 0;
   348		switch (size) {
   349		case I2C_SMBUS_QUICK:
   350			msg[0].len = 0;
   351			/* Special case: The read/write field is used as data */
   352			msg[0].flags = flags | (read_write == I2C_SMBUS_READ ?
   353						I2C_M_RD : 0);
   354			num = 1;
   355			break;
   356		case I2C_SMBUS_BYTE:
   357			if (read_write == I2C_SMBUS_READ) {
   358				/* Special case: only a read! */
   359				msg[0].flags = I2C_M_RD | flags;
   360				num = 1;
   361			}
   362			break;
   363		case I2C_SMBUS_BYTE_DATA:
   364			if (read_write == I2C_SMBUS_READ)
   365				msg[1].len = 1;
   366			else {
   367				msg[0].len = 2;
   368				msgbuf0[1] = data->byte;
   369			}
   370			break;
   371		case I2C_SMBUS_WORD_DATA:
   372			if (read_write == I2C_SMBUS_READ)
   373				msg[1].len = 2;
   374			else {
   375				msg[0].len = 3;
   376				msgbuf0[1] = data->word & 0xff;
   377				msgbuf0[2] = data->word >> 8;
   378			}
   379			break;
   380		case I2C_SMBUS_PROC_CALL:
   381			num = 2; /* Special case */
   382			read_write = I2C_SMBUS_READ;
   383			msg[0].len = 3;
   384			msg[1].len = 2;
   385			msgbuf0[1] = data->word & 0xff;
   386			msgbuf0[2] = data->word >> 8;
   387			break;
   388		case I2C_SMBUS_BLOCK_DATA:
   389			if (read_write == I2C_SMBUS_READ) {
   390				msg[1].flags |= I2C_M_RECV_LEN;
   391				msg[1].len = 1; /* block length will be added by
   392						   the underlying bus driver */
   393				i2c_smbus_try_get_dmabuf(&msg[1], 0);
   394			} else {
   395				msg[0].len = data->block[0] + 2;
   396				if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
   397					dev_err(&adapter->dev,
   398						"Invalid block write size %d\n",
   399						data->block[0]);
   400					return -EINVAL;
   401				}
   402	
   403				i2c_smbus_try_get_dmabuf(&msg[0], command);
   404				for (i = 1; i < msg[0].len; i++)
   405					msg[0].buf[i] = data->block[i - 1];
   406			}
   407			break;
   408		case I2C_SMBUS_BLOCK_PROC_CALL:
   409			num = 2; /* Another special case */
   410			read_write = I2C_SMBUS_READ;
   411			if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
   412				dev_err(&adapter->dev,
   413					"Invalid block write size %d\n",
   414					data->block[0]);
   415				return -EINVAL;
   416			}
   417	
   418			msg[0].len = data->block[0] + 2;
   419			i2c_smbus_try_get_dmabuf(&msg[0], command);
   420			for (i = 1; i < msg[0].len; i++)
   421				msg[0].buf[i] = data->block[i - 1];
   422	
   423			msg[1].flags |= I2C_M_RECV_LEN;
   424			msg[1].len = 1; /* block length will be added by
   425					   the underlying bus driver */
   426			i2c_smbus_try_get_dmabuf(&msg[1], 0);
   427			break;
   428		case I2C_SMBUS_I2C_BLOCK_DATA:
   429			if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
   430				dev_err(&adapter->dev, "Invalid block %s size %d\n",
   431					read_write == I2C_SMBUS_READ ? "read" : "write",
   432					data->block[0]);
   433				return -EINVAL;
   434			}
   435	
   436			if (read_write == I2C_SMBUS_READ) {
   437				msg[1].len = data->block[0];
   438				i2c_smbus_try_get_dmabuf(&msg[1], 0);
   439			} else {
   440				msg[0].len = data->block[0] + 1;
   441	
   442				i2c_smbus_try_get_dmabuf(&msg[0], command);
   443				for (i = 1; i <= data->block[0]; i++)
   444					msg[0].buf[i] = data->block[i];
   445			}
   446			break;
   447		default:
   448			dev_err(&adapter->dev, "Unsupported transaction %d\n", size);
   449			return -EOPNOTSUPP;
   450		}
   451	
   452		i = ((flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK
   453					      && size != I2C_SMBUS_I2C_BLOCK_DATA);
   454		if (i) {
   455			/* Compute PEC if first message is a write */
   456			if (!(msg[0].flags & I2C_M_RD)) {
   457				if (num == 1) /* Write only */
   458					i2c_smbus_add_pec(&msg[0]);
   459				else /* Write followed by read */
   460					partial_pec = i2c_smbus_msg_pec(0, &msg[0]);
   461			}
   462			/* Ask for PEC if last message is a read */
   463			if (msg[num-1].flags & I2C_M_RD)
   464				msg[num-1].len++;
   465		}
   466	
   467		status = i2c_transfer(adapter, msg, num);
   468		if (status < 0)
   469			return status;
   470		if (status != num)
   471			return -EIO;
   472	
   473		/* Check PEC if last message is a read */
   474		if (i && (msg[num-1].flags & I2C_M_RD)) {
   475			status = i2c_smbus_check_pec(partial_pec, &msg[num-1]);
   476			if (status < 0)
   477				return status;
   478		}
   479	
   480		if (read_write == I2C_SMBUS_READ)
   481			switch (size) {
   482			case I2C_SMBUS_BYTE:
   483				data->byte = msgbuf0[0];
   484				break;
   485			case I2C_SMBUS_BYTE_DATA:
   486				data->byte = msgbuf1[0];
   487				break;
   488			case I2C_SMBUS_WORD_DATA:
   489			case I2C_SMBUS_PROC_CALL:
   490				data->word = msgbuf1[0] | (msgbuf1[1] << 8);
   491				break;
   492			case I2C_SMBUS_I2C_BLOCK_DATA:
   493				for (i = 0; i < data->block[0]; i++)
   494					data->block[i + 1] = msg[1].buf[i];
   495				break;
   496			case I2C_SMBUS_BLOCK_DATA:
   497			case I2C_SMBUS_BLOCK_PROC_CALL:
   498				for (i = 0; i < msg[1].buf[0] + 1; i++)
   499					data->block[i] = msg[1].buf[i];
   500				break;
   501			}
   502	
   503		if (msg[0].flags & I2C_M_DMA_SAFE)
   504			kfree(msg[0].buf);
   505		if (msg[1].flags & I2C_M_DMA_SAFE)
   506			kfree(msg[1].buf);
   507	
   508		return 0;
   509	}
   510	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--0F1p//8PRICkK4MW
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RznscCvz/10BDmE1bQEA

--0F1p//8PRICkK4MW--
