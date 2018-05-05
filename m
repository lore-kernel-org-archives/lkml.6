Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbeEEKPw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:15:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:59359 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbeEEKPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:15:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,365,1520924400";
   d="gz'50?scan'50,208,50";a="225992948"
Date: Sat, 5 May 2018 18:15:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Wenwen Wang <wang6495@umn.edu>
Cc: kbuild-all@01.org, Wenwen Wang <wang6495@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: core-smbus: fix a potential uninitialization bug
Message-ID: <201805051812.9h3XU1AJ%fengguang.wu@intel.com>
References: <1525484596-5585-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <1525484596-5585-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wenwen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on v4.17-rc3 next-20180504]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wenwen-Wang/i2c-core-smbus-fix-a-potential-uninitialization-bug/20180505-164208
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: i386-randconfig-a0-201817 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers//i2c/i2c-core-smbus.c: In function 'i2c_smbus_xfer_emulated':
>> drivers//i2c/i2c-core-smbus.c:347:2: error: 'msgbug1' undeclared (first use in this function)
     msgbug1[0] = 0;
     ^
   drivers//i2c/i2c-core-smbus.c:347:2: note: each undeclared identifier is reported only once for each function it appears in

vim +/msgbug1 +347 drivers//i2c/i2c-core-smbus.c

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

--SLDf9lqlvOQaIe6s
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--SLDf9lqlvOQaIe6s--
